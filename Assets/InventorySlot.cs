using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class InventorySlot : MonoBehaviour, IDropHandler
{
    public static List<InventorySlot> allSlots = new List<InventorySlot>(); // 用來追踪所有槽位的列表

    private void Awake()
    {
        allSlots.Add(this); // 將每個槽位添加到列表中
    }

    public void OnDrop(PointerEventData eventData) 
    {
        // 檢查是否有被拖動的物體
        GameObject dropped = eventData.pointerDrag;
        if (dropped != null)
        {
            DraggableItem draggableItem = dropped.GetComponent<DraggableItem>();
            // 檢查拖動的物體是否有 DraggableItem 組件
            if (draggableItem != null)
            {
                // 如果 InventorySlot 沒有子物體，則將拖動的物體放入
                if (transform.childCount == 0) 
                {
                    draggableItem.parentAfterDrag = transform;

                    Debug.Log("卡片放置完成，檢查所有槽位...");
                    // 在放置此卡片後檢查是否所有槽位都已填滿
                    if (CheckAllSlotsFilled())
                    {
                
                        // 執行其他操作，例如顯示通知或禁用卡片移動
                        OnAllSlotsFilled();
                    }
                }
            }
        }
    }

    // 檢查所有槽位是否已填滿的函數
    public static bool CheckAllSlotsFilled()
    {
        foreach (InventorySlot slot in allSlots)
        {
            if (slot.transform.childCount == 0)
            {
                return false; // 如果有任何槽位是空的，返回 false
            }
        }
        return true; // 所有槽位已填滿
    }

    // 所有槽位填滿後執行的操作
    private void OnAllSlotsFilled()
    {
        // 此處執行您希望的操作，例如顯示通知或禁用卡片拖動
        Debug.Log("所有槽位已填滿！可以在這裡執行其他操作。");
        
        // 禁用所有 DraggableItem 的拖動功能
        DraggableItem[] draggableItems = FindObjectsOfType<DraggableItem>();
        foreach (DraggableItem item in draggableItems)
        {
            item.enabled = false; // 禁用 DraggableItem 腳本，防止繼續拖動卡片
        }

        // 您也可以在這裡顯示通知或提示用戶進行下一步操作
        // 例如顯示一個屏幕上的 UI 通知：
        // ShowNotification();
    }
}
