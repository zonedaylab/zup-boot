package cn.zup.bi.utils;

public class BIConfig {

    /***************************************************************
     钻取方式
     1.NONE
     2.分段
     3.路径
     ****************************************************************/

    public interface DRILL_TYPE{
         int DRILL_TYPE_NONE=1;//1.NONE
         int DRILL_TYPE_SEG=2;// 2.分段
         int DRILL_TYPE_PATH=3;// 3.路径
         int DRILL_TYPE_DIFF_TOPIC=4;//不同主题
    }
    /*
    主题表的数据字段类型

    * */
    public interface FIELD_TYPE{
        int ROW_DIM=1;//行维度
        int COL_DIM=2;//列维度
        int INDICATOR=3;//指标数据
    }

    public interface BLOCK_TYPE {
        int TABLE=1;
    }

}
