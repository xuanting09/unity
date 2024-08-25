using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class InventorySlot : MonoBehaviour, IDropHandler
{
    public void OnDrop(PointerEventData eventData) {
        // 检查是否有物体被拖拽
        GameObject dropped = eventData.pointerDrag;
        if (dropped != null)
        {
            DraggableItem draggableItem = dropped.GetComponent<DraggableItem>();
            // 检查拖拽物体是否有 DraggableItem 组件
            if (draggableItem != null)
            {
                // 如果 InventorySlot 没有子物体，则将拖拽物体放入
                if (transform.childCount == 0) 
                {
                    draggableItem.parentAfterDrag = transform;
                }
            }
        }
    }
}
