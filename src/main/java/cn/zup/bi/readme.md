#### 1.业务说明


1. ##### 维度的排列说明

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

2. ##### GenerateTableRows根据列维度生成行信息,返回值listRows<String>

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

‘

mapIndicatorData   key,value ,
key为 维度信息   r1,r2...c1,c2   分别代表行维度 ，列维度的数据，
value为汇聚数据
例如（dimkey=山东省，集体企业，  value=5）


根据维度定义 表格的长度和宽度，假设行维度 4个数据，列维度为3个数据，则3行4列的表格。

#### 2.设计思路

1. 行维度、列维度只取其一能够展示.ok

1. 能够拼接多个报表进行展示
2. 多个报表块的查询时写入存在严重的问题，需要重构
3. 重构代码，加入图形展示、大屏展示、混合图表展示。
4. 能够拖拽维度展示

f. 钻取：

钻取方式：

1.NONE
2.分段
3.路径

钻取信息：

1.NONE
2.分段  252322  进行划分  2-2-2    省市县
3.路径 
4.不同主题连接，dim_field进行设置，例如 省级主题-城市主题-县级主题  