using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using TMPro;
using System.Collections.Generic;


public class BingoGame : MonoBehaviour
{
    public GameObject weekPlanDoneScreen; // 參考到結束遊戲的屏幕
    public GameObject GameFinish; // 參考到結束遊戲的屏幕
    public GameObject Backgroundend; // 參考到背景圖片
    public Button resetButton; // 參考到重置按鈕
    public Button replayButton; // 參考到重玩按鈕
    public Transform gridParent; // 父物件，包含所有卡片的格子

    private Dictionary<Button, string> originalButtonTexts = new Dictionary<Button, string>(); // 存儲每個按鈕的原始文本

    void Start()
    {
        // 確保遊戲開始時隱藏結束屏幕和按鈕
        weekPlanDoneScreen.SetActive(false);
        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
        GameFinish.SetActive(false);
        Backgroundend.SetActive(false);  // 隱藏背景圖片

        // 添加按鈕事件
        resetButton.onClick.AddListener(ResetGame);
        replayButton.onClick.AddListener(ReplayGame);
    }

    public void EndGame()
    {
        Debug.Log("EndGame 方法被呼叫");

        // 停止所有 DraggableItem 的拖動功能
        DisableDragging();
        Backgroundend.SetActive(true);

        // 顯示結束遊戲的屏幕和按鈕
        weekPlanDoneScreen.SetActive(true);

        // 開始協程來隱藏結束屏幕並轉換卡片為按鈕
        StartCoroutine(HideWeekPlanDoneScreenAndConvertCards());
    }

    private void DisableDragging()
    {
        DraggableItem[] draggableItems = FindObjectsOfType<DraggableItem>();

        foreach (DraggableItem item in draggableItems)
        {
            item.enabled = false; // 禁用 DraggableItem 腳本，防止繼續拖動卡片
        }
    }

    private IEnumerator HideWeekPlanDoneScreenAndConvertCards()
    {
        // 等待 5 秒鐘
        yield return new WaitForSeconds(2);

        // 隱藏結束遊戲的屏幕
        weekPlanDoneScreen.SetActive(false);
        Backgroundend.SetActive(false);

        // 將格子中的卡片轉換為按鈕
        ConvertCardsToButtons();
    }

    private void ConvertCardsToButtons()
    {
        foreach (Transform slot in gridParent)
        {
            if (slot.childCount > 0)
            {
                // 將卡片轉換為按鈕
                GameObject card = slot.GetChild(0).gameObject;
                Button button = card.AddComponent<Button>();

                // 獲取原始文本並存儲
                TMP_Text buttonText = card.GetComponentInChildren<TMP_Text>();
                if (buttonText != null)
                {
                    originalButtonTexts[button] = buttonText.text;
                }

                // 添加點擊事件
                button.onClick.AddListener(() => OnCardButtonClick(button));
            }
        }
    }

    private void OnCardButtonClick(Button button)
    {
        // 確保按鈕內有 TMP_Text 組件（TextMeshPro）
        TMP_Text buttonText = button.GetComponentInChildren<TMP_Text>();
        if (buttonText != null)
        {
            // 將按鈕文字更改為“congratulating”
            buttonText.text = "congratulating";
        }
        else
        {
            Debug.LogError("按鈕上未找到 TMP_Text 組件");
        }

        // 檢查所有按鈕是否都變為“congratulating”
        if (CheckAllButtonsCongratulating())
        {
            // 顯示重置和重玩按鈕以及背景
            resetButton.gameObject.SetActive(true);
            replayButton.gameObject.SetActive(true);
            GameFinish.SetActive(true);
            Backgroundend.SetActive(true);  // 顯示背景圖片
        }
    }

    private bool CheckAllButtonsCongratulating()
    {
        foreach (Transform slot in gridParent)
        {
            // 跳過 InventorySlot(25) 的檢查
            if (slot.name == "InventorySlot(25)")
            {
                continue; // 跳過這個槽位的檢查
            }

            if (slot.childCount > 0)
            {
                Button button = slot.GetChild(0).GetComponent<Button>();
                if (button != null)
                {
                    TMP_Text buttonText = button.GetComponentInChildren<TMP_Text>();
                    if (buttonText == null || buttonText.text != "congratulating")
                    {
                        return false; // 如果有任何按鈕未變為“congratulating”，返回 false
                    }
                }
            }
        }
        return true; // 所有按鈕（除了 InventorySlot(25)）都變為“congratulating”
    }

    private void ResetGame()
{
    // 將所有卡片移回初始位置並恢復 DraggableItem 腳本
    foreach (Transform slot in gridParent)
    {
        if (slot.childCount > 0)
        {
            GameObject card = slot.GetChild(0).gameObject;
            DraggableItem draggableItem = card.GetComponent<DraggableItem>();
            if (draggableItem != null && draggableItem.initialSlot != null)
            {
                // 將卡片移回初始槽位
                card.transform.SetParent(draggableItem.initialSlot);
                card.transform.localPosition = Vector3.zero;

                // 恢復 DraggableItem 腳本
                draggableItem.enabled = true;

                // 確保 TextMeshPro 的 Raycast Target 是啟用的
                TextMeshProUGUI tmpText = card.GetComponent<TextMeshProUGUI>();
                if (tmpText != null)
                {
                    tmpText.raycastTarget = true;
                }
            }
            // 移除按鈕組件以恢復卡片為原始狀態
            Destroy(card.GetComponent<Button>());
        }
    }

    // 重置遊戲狀態
    weekPlanDoneScreen.SetActive(false);
    resetButton.gameObject.SetActive(false);
    replayButton.gameObject.SetActive(false);
    GameFinish.SetActive(false);
    Backgroundend.SetActive(false);
}
    private void ReplayGame()
    {
        // 恢復按鈕的原始文本
        foreach (Transform slot in gridParent)
        {
            if (slot.childCount > 0)
            {
                Button button = slot.GetChild(0).GetComponent<Button>();
                if (button != null && originalButtonTexts.ContainsKey(button))
                {
                    TMP_Text buttonText = button.GetComponentInChildren<TMP_Text>();
                    if (buttonText != null)
                    {
                        buttonText.text = originalButtonTexts[button]; // 恢復原始文本
                    }
                }
            }
        }

        // 重置按鈕狀態
        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
        GameFinish.SetActive(false);
        Backgroundend.SetActive(false);
    }
}
