#### 1.业务说明


1. 维度的排列说明
    * 列维度:纵向排列    
    * 例如 dimName="省份" dimValue=山东省/河南省/....
        + 纵向排列：    
        + 山东省
        + 河南省
        + 河北省
        + ......

     * 行维度，例如by liuxf
         * dimName=行业种类
         * dimValue= 电力/ 服务/水务等
         * 维度横向生成
         * 电力 服务   水务   。。。。。。

2. GenerateTableRows根据列维度生成行信息,返回值listRows<String>

   ```
   private void GeneTableRows(int dimCol, List<BIDimData> BIColDimDatas , String colsNames, int colSize, List<String> listRows)
   ```

   返回值为listRows，为总共要生成的行的数量，每列的信息格式为  dim1name,dim2name,dim3name,..

   例如维度为dim1 省份（山东省，河南省，河北省...)，dim2 矿类（金属，煤矿）

|        |              |                     |
| ------ | ------------ | ------------------- |
| 第一行 | 山东省，金属 | listRows<String>[0] |
| 第二行 | 山东省，煤矿 | listRows<String>[1] |
| 第三行 | 河南省，金属 | listRows<String>[2] |
| 第四行 | 河南省，煤矿 | listRows<String>[3] |
| 第五行 | 河北省，金属 | listRows<String>[4] |
| 第六行 | 河北省，煤矿 | listRows<String>[5] |
|        |              |                     |



2. GenerateTableCols 根据行维度生成列信息（多少列）

   ```
   private void GeneTableCols(int dimRow, List<BIDimData> BIRowDimDatas , String rowsNames, int rowSize, List<String> listCols)
   ```

   根据行维度生成列信息,返回值为listCols，为总共要生成的列的数量，每列的信息格式为  dim1name,dim2name,dim3name,....

* 例如行维度为 dim1类型（饮料 膨化食品 矿泉水），dim2品牌（可口可乐 哇哈哈），

|      | 第一列         | 第二列       | 第三列               | 第四列           | 第五列         |
| ---- | -------------- | ------------ | -------------------- | ---------------- | -------------- |
|      | 饮料，可口可乐 | 饮料，哇哈哈 | 膨化食品，可口可乐， | 矿泉水，可口可乐 | 矿泉水，哇哈哈 |
|      | listCols[0]    | listCols[1]  | listCols[2]          | listCols[3]      | listCols[4]    |
|      |                |              |                      |                  |                |

#### 2.设计思路

```
4，是否可以允许没有行维度和列维度。
5.blockid的诡异写入方法需要更新
6.多个报表融合
```

每个维度列表设置一个hash表，对应索引。Dim<string,value>map

根据维度字段信息快速获索引，根据行维度，列维的索引，取所在行、列位置信息，

```
mapIndicatorData   key,value ,
key为 维度信息   r1,r2...c1,c2   分别代表行维度 ，列维度的数据，
value为汇聚数据
例如（dimkey=山东省，集体企业，  value=5）

定义Map<String dimName,Hashmap<String dimData, int dimDataValue>> mapDimConfig;

根据维度定义 表格的长度和宽度，假设行维度 4个数据，列维度为3个数据，则3行4列的表格。
```

