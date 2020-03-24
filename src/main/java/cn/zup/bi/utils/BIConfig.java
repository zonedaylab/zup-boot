package cn.zup.bi.utils;

public class BIConfig {



    /***************************************************************
     一、					--命令类型定义--

     钻取方式

     1.NONE
     2.分段
     3.路径
     ****************************************************************/

    public interface DRILL_TYPE{
         int DRILL_TYPE_NONE=1;
         int DRILL_TYPE_SEG=2;
         int DRILL_TYPE_PATH=3;

    }
}
