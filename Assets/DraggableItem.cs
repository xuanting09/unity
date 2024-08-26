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

    // 垂直间距
    public float verticalSpacing = 50f; // 可以根据需求调整这个值

    // 存放不同文本的数组
    public string[] texts = { "文本1", "文本2", "文本3", "文本4", "文本5" };  // 根據你的需求設置這些文本

    void Start()
    {
        // 将初始父物体设置为 InventorySlot
        if (initialSlot != null)
        {
            transform.SetParent(initialSlot);

            // 设置垂直位置时考虑到每个项目之间的间距
            RectTransform rectTransform = GetComponent<RectTransform>();
            int siblingIndex = transform.GetSiblingIndex();
            float yOffset = siblingIndex * verticalSpacing;
            rectTransform.anchoredPosition = new Vector2(rectTransform.anchoredPosition.x, -yOffset);

            // 設置Text (TMP)的文本內容
            TextMeshProUGUI tmp = GetComponent<TextMeshProUGUI>();
            if (tmp != null && siblingIndex < texts.Length)
            {
                tmp.text = texts[siblingIndex];
            }
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

        // 获取鼠标位置下的 UI 对象
        GameObject dropTarget = eventData.pointerCurrentRaycast.gameObject;

        if (dropTarget != null)
        {
            Debug.Log("Raycast hit: " + dropTarget.name);

            // 检查是否放置在 InventorySlot 上
            InventorySlot slot = dropTarget.GetComponent<InventorySlot>();
            if (slot != null && slot.transform.childCount == 0) // 确保槽位为空
            {
                transform.SetParent(dropTarget.transform);
                transform.localPosition = Vector3.zero;
                Debug.Log("Dropped into: " + dropTarget.name);
            }
            else
            {
                // 如果不是放在有效的 InventorySlot 上，或者槽位已满，则返回原始位置
                transform.SetParent(parentAfterDrag);
                transform.localPosition = Vector3.zero;
                Debug.Log("Dropped back to original parent: " + parentAfterDrag.name);
            }
        }
        else
        {
            // 如果 Raycast 没有命中任何对象，则返回原始位置
            transform.SetParent(parentAfterDrag);
            transform.localPosition = Vector3.zero;
            Debug.Log("Raycast missed. Dropped back to original parent: " + parentAfterDrag.name);
        }

        // 恢复 Text (TMP) 的 Raycast Target
        GetComponent<TextMeshProUGUI>().raycastTarget = true;
        Debug.Log("Text Raycast target enabled");
    }
}
