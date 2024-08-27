using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using TMPro;

public class DraggableItem : MonoBehaviour, IBeginDragHandler, IDragHandler, IEndDragHandler
{
    [HideInInspector] public Transform parentAfterDrag;

    // 初始槽位的引用
    public Transform initialSlot;

    // 垂直間距
    public float verticalSpacing = 50f; // 可以根據需求調整這個值

    void Start()
    {
        // 將初始父物體設置為 initialSlot
        if (initialSlot != null)
        {
            transform.SetParent(initialSlot);

            // 設置垂直位置時考慮到每個項目之間的間距
            RectTransform rectTransform = GetComponent<RectTransform>();
            int siblingIndex = transform.GetSiblingIndex();
            float yOffset = siblingIndex * verticalSpacing;
            rectTransform.anchoredPosition = new Vector2(rectTransform.anchoredPosition.x, -yOffset);
        }
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        Debug.Log("Begin drag");
        parentAfterDrag = transform.parent;
        transform.SetParent(transform.root);
        transform.SetAsLastSibling();

        // 禁用 Text (TMP) 的 Raycast Target
        GetComponent<TextMeshProUGUI>().raycastTarget = false;
        Debug.Log("Text Raycast target disabled");
    }

    public void OnDrag(PointerEventData eventData)
    {
        Debug.Log("Dragging");
        transform.position = Input.mousePosition;
    }

    public void OnEndDrag(PointerEventData eventData)
    {
        Debug.Log("End drag");

        GameObject dropTarget = eventData.pointerCurrentRaycast.gameObject;

        if (dropTarget != null)
        {
            Debug.Log("Raycast hit: " + dropTarget.name);

            InventorySlot slot = dropTarget.GetComponent<InventorySlot>();
            if (slot != null)
            {
                Debug.Log("InventorySlot found: " + slot.name + ", Child count: " + slot.transform.childCount);
                if (slot.transform.childCount == 0) // 確保槽位為空
                {
                    transform.SetParent(dropTarget.transform);
                    transform.localPosition = Vector3.zero;
                    Debug.Log("Dropped into: " + dropTarget.name);
                }
                else
                {
                    Debug.Log("Slot already occupied. Returning to original parent.");
                    transform.SetParent(parentAfterDrag);
                    transform.localPosition = Vector3.zero;
                }
            }
            else
            {
                Debug.Log("Drop target is not an InventorySlot. Returning to original parent.");
                transform.SetParent(parentAfterDrag);
                transform.localPosition = Vector3.zero;
            }
        }
        else
        {
            Debug.Log("Raycast missed. Returning to original parent.");
            transform.SetParent(parentAfterDrag);
            transform.localPosition = Vector3.zero;
        }

        GetComponent<TextMeshProUGUI>().raycastTarget = true;
        Debug.Log("Text Raycast target enabled");
    }
}
