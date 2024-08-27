using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class WeekPlanManager : MonoBehaviour
{
    public GameObject weekPlanDonePanel; // Week Plan 完成的面板
    public Button[] cardButtons; // 卡片按鈕
    public TextMeshProUGUI resultText; // 顯示責備/祝賀信息的文本
    public Button resetButton; // Reset Game 按鈕
    public Button replayButton; // Replay 按鈕

    private int completedCards = 0; // 已完成的卡片數量
    private bool gameFinished = false;

    void Start()
    {
        // 初始化時隱藏完成面板
        weekPlanDonePanel.SetActive(false);

        // 為所有卡片按鈕綁定點擊事件
        foreach (Button btn in cardButtons)
        {
            btn.onClick.AddListener(() => OnCardClick(btn));
        }

        // 隱藏 Reset 和 Replay 按鈕，初始化時
        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
    }

    // 當卡片按鈕被點擊時執行
    public void OnCardClick(Button btn)
    {
        if (gameFinished) return;

        // 將按鈕設置為綠色，並顯示 "Congratulating"
        btn.GetComponent<Image>().color = Color.green;
        btn.GetComponentInChildren<TextMeshProUGUI>().text = "Congratulating";

        completedCards++;

        // 如果所有卡片都已完成
        if (completedCards == cardButtons.Length)
        {
            ShowCompletionMessage();
        }
    }

    // 顯示 Week Plan 完成的提示信息
    public void ShowCompletionMessage()
    {
        weekPlanDonePanel.SetActive(true);
        gameFinished = true;

        // 判斷完成情況並顯示相應信息
        if (completedCards == cardButtons.Length)
        {
            resultText.text = "Congratulations! You have completed all your tasks for the week!";
        }
        else
        {
            resultText.text = "You still have tasks remaining. Keep going!";
        }

        // 顯示 Reset 和 Replay 按鈕
        resetButton.gameObject.SetActive(true);
        replayButton.gameObject.SetActive(true);
    }

    // 檢查是否所有卡片都已擺放完成
    public bool AllCardsPlaced()
    {
        // 根據遊戲邏輯檢查是否所有卡片都已擺放
        // 如果已經擺放完成，返回 true
        // 注意：這裡假設卡片數量已經被記錄，具體邏輯根據你的需求調整
        return completedCards == cardButtons.Length;
    }

    // 重置遊戲
    public void OnResetGame()
    {
        // 重置遊戲邏輯
        completedCards = 0;
        gameFinished = false;
        weekPlanDonePanel.SetActive(false);

        foreach (Button btn in cardButtons)
        {
            btn.GetComponent<Image>().color = Color.white;
            btn.GetComponentInChildren<TextMeshProUGUI>().text = ""; // 重置文字
        }

        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
    }

    // 重播遊戲（保持相同的卡片順序）
    public void OnReplayGame()
    {
        // 重置狀態，但保留卡片順序
        completedCards = 0;
        gameFinished = false;
        weekPlanDonePanel.SetActive(false);

        foreach (Button btn in cardButtons)
        {
            btn.GetComponent<Image>().color = Color.white;
            btn.GetComponentInChildren<TextMeshProUGUI>().text = ""; // 重置文字
        }

        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
    }
}
