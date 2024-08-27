using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using System.IO;

public class LoadTextFromJSON : MonoBehaviour
{
    public TextMeshProUGUI[] textElements; // 連接到場景中的 TMP 元素
    public static List<string> loadedTexts = new List<string>(); // 改為靜態變量

    void Start()
    {
        LoadDataFromJSON();

        // 將讀取到的文本設置到 TMP 元素
        for (int i = 0; i < textElements.Length && i < loadedTexts.Count; i++)
        {
            textElements[i].text = loadedTexts[i];
        }
    }

    void LoadDataFromJSON()
    {
        string filePath = Path.Combine(Application.streamingAssetsPath, "Bingocardname.json");

        Debug.Log("Loading JSON file from: " + filePath);

        if (File.Exists(filePath))
        {
            string jsonData = File.ReadAllText(filePath);
            Debug.Log("JSON data: " + jsonData);

            try
            {
                var jsonObjects = JsonUtility.FromJson<JSONObjectArray>(jsonData);

                if (jsonObjects != null && jsonObjects.items != null)
                {
                    foreach (var obj in jsonObjects.items)
                    {
                        loadedTexts.Add(obj.text);
                        Debug.Log("Loaded text: " + obj.text);
                    }
                }
                else
                {
                    Debug.LogError("JSON parsed but no items found.");
                }
            }
            catch (System.Exception ex)
            {
                Debug.LogError("Failed to parse JSON: " + ex.Message);
            }
        }
        else
        {
            Debug.LogError("JSON file not found at: " + filePath);
        }
    }

}

// JSON 文件對應的數據結構
[System.Serializable]
public class JSONObject
{
    public string text;
}

[System.Serializable]
public class JSONObjectArray
{
    public JSONObject[] items;
}
