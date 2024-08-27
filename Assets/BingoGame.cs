using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class BingoGame : MonoBehaviour
{
    public GameObject weekPlanDoneScreen; // 參考到結束遊戲的屏幕
    public Button resetButton; // 參考到重置按鈕
    public Button replayButton; // 參考到重玩按鈕
    
    void Start()
    {
        // 確保遊戲開始時隱藏結束屏幕和按鈕
        weekPlanDoneScreen.SetActive(false);
        resetButton.gameObject.SetActive(false);
        replayButton.gameObject.SetActive(false);
    }

    public void EndGame()
    {
        Debug.Log("EndGame 方法被呼叫");

        // 停止所有 DraggableItem 的拖動功能
        DisableDragging();

        // 顯示結束遊戲的屏幕和按鈕
        weekPlanDoneScreen.SetActive(true);
        resetButton.gameObject.SetActive(true);
        replayButton.gameObject.SetActive(true);

        // 開始協程來隱藏結束屏幕
        StartCoroutine(HideWeekPlanDoneScreenAfterDelay());
    }

    private void DisableDragging()
    {
        DraggableItem[] draggableItems = FindObjectsOfType<DraggableItem>();

        foreach (DraggableItem item in draggableItems)
        {
            item.enabled = false; // 禁用 DraggableItem 腳本，防止繼續拖動卡片
        }
    }

    private IEnumerator HideWeekPlanDoneScreenAfterDelay()
    {
        Debug.Log("協程開始，等待 5 秒...");
        // 等待 5 秒鐘
        yield return new WaitForSeconds(5);

        Debug.Log("5 秒結束，隱藏結束屏幕");
        // 隱藏結束遊戲的屏幕
        weekPlanDoneScreen.SetActive(false);
        weekPlanDoneScreen.SetActive(false);
        weekPlanDoneScreen.SetActive(false);

        // 如果需要，您也可以在這裡隱藏按鈕
        // resetButton.gameObject.SetActive(false);
        // replayButton.gameObject.SetActive(false);
    }
}
