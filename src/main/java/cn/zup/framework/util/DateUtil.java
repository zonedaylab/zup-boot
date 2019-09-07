package cn.zup.framework.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil
{

	/**
	 * 按默认格式转换日期字符串为日期对象(格式为:yyyy-MM-dd)
	 * @param datestr:日期型字符串
	 * @return:Date对象
	 */
	public static Date parseDateStr(String datestr)
	{
		String tmp = "yyyy-MM-dd";
		Date dt = null;
		SimpleDateFormat formatter = new SimpleDateFormat(tmp);
		try
		{
			dt = formatter.parse(datestr);
		} catch (Exception ex)
		{
			return null;
		}
		return dt;
	}

	/**
	 * 将日期字符串转换成日期类型
	 * @param datestr:日期型字符串
	 * @param format:格式串
	 * @return:Date对象
	 */

	public static Date parseDateStr(String datestr, String format)
	{
		String tmp = "yyyy-MM-dd";
		if (format != null && !format.equals(""))
		{
			tmp = format;
		}
		Date dt = null;
		SimpleDateFormat formatter = new SimpleDateFormat(tmp);
		try
		{
			dt = formatter.parse(datestr);
		} catch (Exception ex)
		{
			return null;
		}
		return dt;
	}

	/**
	 * 
	 * 按指定格式格式化日期
	 * 
	 * 
	 * 
	 * @param dt
	 *            :要格式化的日期
	 * 
	 * @param format
	 *            ：指定格式
	 * 
	 * @return：返回格式化后的字符串型日期
	 */

	public static String formatdate(Date dt, String format)

	{

		String temp;

		if (dt == null)

		{

			return "";

		}

		if ((format == null) || (format.equals("")))

		{

			temp = "yyyy-MM-dd";

		} else

		{

			temp = format;

		}

		SimpleDateFormat formatter = new SimpleDateFormat(temp);

		String s = formatter.format(dt);

		return s;

	}

	/**
	 * 
	 * 返回指定日期加上指定天数后的日期
	 * 
	 * 
	 * 
	 * @param dt
	 *            ：指定日期
	 * 
	 * @param days
	 *            ：要加的天数，负值表示减。
	 * 
	 * @return：计算后所得日期
	 */

	public static Date adddays(Date dt, long days)

	{

		Date rslt;

		int day = (int) days;

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		cal.add(Calendar.DATE, day);

		rslt = cal.getTime();

		/*
		 * 
		 * long t = dt.getTime(); t += days*24*3600*1000; Date rslt = new
		 * 
		 * Date(t);
		 */

		return rslt;

	}

	/**
	 * 
	 * 计算两个日期之间的间隔天数
	 * 
	 * 
	 * 
	 * @param start
	 * 
	 * @param end
	 * 
	 * @return
	 */

	public static long equalDays(Date start, Date end)

	{

		long days = 0;

		long st = start.getTime();

		long en = end.getTime();

		long times = en - st;

		days = times / (24 * 3600 * 1000);

		return days;

	}

	/**
	 * 
	 * 返回指定日期加上指定时间的日期
	 * 
	 * 
	 * 
	 * @param dt
	 *            ：指定日期
	 * 
	 * @param times
	 *            ：要加的时间，负值表示减。
	 * 
	 * @return：计算后所得日期
	 */

	public static Date addtimes(Date dt, long times)

	{

		long t = dt.getTime();

		t += times;

		Date rslt = new Date(t);

		return rslt;

	}

	/**
	 * 
	 * 返回指定日期加上指定月数的日期
	 * 
	 * 
	 * 
	 * @param dt
	 *            :指定日期
	 * 
	 * @param month
	 *            :要加的月数
	 * 
	 * @return:计算后所得的日期
	 */

	public static Date addmonth(Date dt, int month)

	{

		Date rslt;

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		cal.add(Calendar.MONTH, month);

		rslt = cal.getTime();

		/*
		 * 
		 * int year = dt.getYear(); int date = dt.getDate(); int m=
		 * 
		 * dt.getMonth(); rslt = new Date(year,m+month,date);
		 */

		return rslt;

	}

	/**
	 * 
	 * 年份增减(谢孝秋)
	 * 
	 * 
	 * 
	 * @param dt
	 * 
	 * @param month
	 * 
	 * @return
	 */

	public static Date addYear(Date dt, int year)

	{

		Date rslt;

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		cal.add(Calendar.YEAR, year);

		rslt = cal.getTime();

		return rslt;

	}

	/**
	 * 
	 * 返回当前的日期
	 * 
	 * 
	 * 
	 * @return java.sqlTimestamp
	 */

	public static Timestamp getNow()

	{

		return new Timestamp(System.currentTimeMillis());

	}

	/**
	 * 
	 * 返回当前的日期的字符表示
	 * 
	 * 
	 * 
	 * @return String
	 */

	public static String getNowDateString()

	{

		return DateUtil.getTimestampString(DateUtil.getNow());

	}

	/**
	 * 
	 * 返回当前的日期时间的字符表示
	 * 
	 * 
	 * 
	 * @return String
	 */

	public static String getNowDateTimeString()

	{

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(

		"yyyy.MM.dd HH:mm:ss");

		Date currentTime_1 = new Date();

		return formatter.format(currentTime_1);

	}

	/**
	 * 
	 * 返回当前的时间的字符表示
	 * 
	 * 
	 * 
	 * @return String
	 */

	public static String getNowTimeString()

	{

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(

		"HH:mm:ss");

		Date currentTime_1 = new Date();

		return formatter.format(currentTime_1);

	}

	/**
	 * 
	 * 返回
	 * 
	 * 
	 * 
	 * @param timestamp
	 * 
	 * @return
	 */

	public static String getTimestampString(Timestamp timestamp)

	{

		if (timestamp == null)

		{

			return "";

		}

		return timestamp.toString().substring(0, 10);

	}

	public static String doubletoDate(double d)

	{

		long l_dt = (long) d;

		Calendar cal = Calendar.getInstance();

		cal.clear();

		cal.set(1899, 11, 30);

		long l_1900 = cal.getTimeInMillis();

		long t = l_1900 + l_dt * 24 * 3600000;

		Date dt = new Date(t);

		String rslt = formatdate(dt, "yyyy-MM-dd");

		return rslt;

	}

	/**
	 * 
	 * 取得所在月的总天数
	 * 
	 * 
	 * 
	 * @param 计算日期
	 * 
	 * @return 天数
	 */

	public static long getDaysofMonth(Date dd)

	{

		long d = 0;

		Calendar nowtime = Calendar.getInstance();

		// int year = dd.getYear() + 1900;

		// int month = dd.getMonth();

		// int date = dd.getDate();

		// nowtime.set(year, month, date);

		nowtime.setTime(dd);

		d = nowtime.getActualMaximum(Calendar.DAY_OF_MONTH); // 获取当月的总天数

		return d;

	}

	/**
	 * 
	 * 取得两个日期相隔的天数 add by hyu
	 * 
	 * 
	 * 
	 * @param d1
	 * 
	 * @param d2
	 * 
	 * @return
	 */

	public static int getDays(Date d1, Date d2)

	{

		GregorianCalendar g1 = new GregorianCalendar();

		g1.setTime(d1);

		GregorianCalendar g2 = new GregorianCalendar();

		g2.setTime(d2);

		int elapsed = 0;

		GregorianCalendar gc1, gc2;

		int judge = 1;

		if (g2.after(g1))

		{

			gc2 = (GregorianCalendar) g2.clone();

			gc1 = (GregorianCalendar) g1.clone();

		} else

		{

			judge = -1;

			gc2 = (GregorianCalendar) g1.clone();

			gc1 = (GregorianCalendar) g2.clone();

		}

		gc1.clear(Calendar.MILLISECOND);

		gc1.clear(Calendar.SECOND);

		gc1.clear(Calendar.MINUTE);

		gc1.clear(Calendar.HOUR_OF_DAY);

		gc2.clear(Calendar.MILLISECOND);

		gc2.clear(Calendar.SECOND);

		gc2.clear(Calendar.MINUTE);

		gc2.clear(Calendar.HOUR_OF_DAY);

		while (gc1.before(gc2))

		{

			gc1.add(Calendar.DATE, 1);

			elapsed++;

		}

		return elapsed * judge;

	}

	/**
	 * 
	 * /** 取得两个日期相隔的月数 不足一个月的按照一个月算 add by hyu
	 * 
	 * 
	 * 
	 * @param d1
	 * 
	 *            开始时间
	 * 
	 * @param d2
	 * 
	 *            终止时间
	 * 
	 * @return
	 */

	public static int getMonths(Date d1, Date d2)

	{

		GregorianCalendar g1 = new GregorianCalendar();

		g1.setTime(d1);

		GregorianCalendar g2 = new GregorianCalendar();

		g2.setTime(d2);

		int elapsed = 0;

		int judge = 1; // 用来标志正负

		GregorianCalendar gc1, gc2;

		if (g2.after(g1))

		{

			gc2 = (GregorianCalendar) g2.clone();

			gc1 = (GregorianCalendar) g1.clone();

		} else

		{

			judge = -1;

			gc2 = (GregorianCalendar) g1.clone();

			gc1 = (GregorianCalendar) g2.clone();

		}

		gc1.clear(Calendar.MILLISECOND);

		gc1.clear(Calendar.SECOND);

		gc1.clear(Calendar.MINUTE);

		gc1.clear(Calendar.HOUR_OF_DAY);

		// gc1.clear(Calendar.DATE);

		gc2.clear(Calendar.MILLISECOND);

		gc2.clear(Calendar.SECOND);

		gc2.clear(Calendar.MINUTE);

		gc2.clear(Calendar.HOUR_OF_DAY);

		// gc2.clear(Calendar.DATE);

		while (gc1.before(gc2))

		{

			gc1.add(Calendar.MONTH, 1);

			elapsed++;

		}

		return elapsed * judge;

	}

	/**
	 * 
	 * getDiff 得到两个日期相差的小时数和分数
	 * 
	 * 
	 * 
	 * @param sdate1
	 * 
	 *            开始日期
	 * 
	 * @param sdate2
	 * 
	 *            结束日期
	 * 
	 * @return 一个小时分的字符串
	 */

	public String getDiff(Date sdate1, Date sdate2)

	{

		long time = 0;

		String zxsj;

		long time1 = sdate1.getTime();

		long time2 = sdate2.getTime();

		time = time2 - time1;

		long diffMins = time / ((60 * 1000)) % 60;

		long diffHours = time / (60 * 60 * 1000);

		if (diffMins < 0)

		{

			diffMins = 0;

		}

		if (diffHours > 0)

		{

			zxsj = new String(diffHours + "小时" + diffMins + "分钟");

		} else

		{

			zxsj = new String(diffMins + "分钟");

		}

		return zxsj;

	}

	/**
	 * 
	 * 
	 * 
	 * @param sdate1
	 * 
	 *            开始日期
	 * 
	 * @param sdate2
	 * 
	 *            结束日期
	 * 
	 * @return 返回两个时间相差的毫秒数
	 */

	public static long getlongDiff(Date sdate1, Date sdate2)

	{

		long time = 0;

		long time1 = sdate1.getTime();

		long time2 = sdate2.getTime();

		time = time2 - time1;

		return time;

	}

	/**
	 * 
	 * Add by xxq
	 * 
	 * 
	 * 
	 * @param sdate1
	 * 
	 * @param sdate2
	 * 
	 * @return 返回两个时间的相差的小时数
	 */

	public static long getDataDiff(Date sdate1, Date sdate2)

	{

		long diffHours = getlongDiff(sdate1, sdate2) / (60 * 60 * 1000);

		return diffHours;

	}

	/**
	 * 
	 * @param sdate1
	 * 
	 * @param sdate2
	 * 
	 * @return 返回两个时间的相差的分钟数
	 */

	public static long getDiffMin(Date sdate1, Date sdate2)

	{

		long diffMins = getlongDiff(sdate1, sdate2) / (60 * 1000);

		return diffMins;

	}

	/**
	 * 
	 * @param dt
	 * 
	 * @return 返回当前的年份
	 */

	public static int getYear(java.util.Date dt)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		return cal.get(Calendar.YEAR);

	}

	/**
	 * 
	 * @param dt
	 * 
	 * @return 返回当前的月份
	 */

	public static int getMonth(java.util.Date dt)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		return cal.get(Calendar.MONTH);

	}

	/**
	 * 
	 * @param dt
	 * 
	 * @return 返回当前的日期
	 */

	public static int getDay(java.util.Date dt)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		return cal.get(Calendar.DATE);

	}

	/**
	 * 
	 * @param dt
	 * 
	 * @return 返回当前的星期数
	 */

	public static int getDayOfWeek(java.util.Date dt)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		return cal.get(Calendar.DAY_OF_WEEK);

	}

	/**
	 * 
	 * @param dt
	 * 
	 * @return 返回当前的小时数
	 */

	public static int getHourOfDay(java.util.Date dt)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(dt);

		return cal.get(Calendar.HOUR_OF_DAY);

	}

	public static Date swithDate(String newDate, String hh, String mm)

	{

		SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		Date date = new Date();

		try

		{

			if (hh != null && hh.length() > 0)

			{

				if (mm != null && mm.length() > 0)

				{

					newDate = newDate + " " + hh + ":" + mm + ":00";

				} else

				{

					newDate = newDate + " " + hh + ":00:00";

				}

			} else

			{

				newDate = newDate + " 00:00:00";

			}

			date = lformat.parse(newDate);

		} catch (Exception e)

		{

			// System.out.println(e.getMessage());

		}

		return date;

	}

	public Date swithDate(Date date, String hh, String mm)

	{

		SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd");

		String newDateStr = "";

		if (date != null)

		{

			newDateStr = lformat.format(date);

		}

		Date newdate = new Date();

		try

		{

			if (newDateStr != null && newDateStr.length() > 0)

			{

				if (hh != null && hh.length() > 0)

				{

					if (mm != null && mm.length() > 0)

					{

						newDateStr = newDateStr + " " + hh + ":" + mm + ":00";

					}

					newDateStr = newDateStr + " " + hh + ":00:00";

				}

				newDateStr = newDateStr + " " + "00:00:00";

			}

			lformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

			newdate = lformat.parse(newDateStr);

		} catch (Exception e)

		{

			// System.out.println(e.getMessage());

		}

		return newdate;

	}

	public static String swithDate(Date newDate)

	{

		SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		if (newDate != null)

		{

			return lformat.format(newDate);

		} else

		{

			return "";

		}

	}
	
	
	public static String swithDate(Date date,String format)
	{

		SimpleDateFormat lformat = new SimpleDateFormat(format);

		if (date != null)

		{

			return lformat.format(date);

		} else

		{

			return "";

		}

	}

	public static Date swithDate(String newDate)

	{

		SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		try

		{

			if (newDate != null)

			{

				date = lformat.parse(newDate);

				return date;

			}

		} catch (Exception e)

		{

			e.printStackTrace();

		}

		return null;

	}

	public static String calTostring( GregorianCalendar cal){
        return "" + cal.get(cal.YEAR) 
              + "-" + (cal.get(Calendar.MONTH) + 1) 
              + "-" + cal.get(Calendar.DATE)
              + " " + cal.get(cal.HOUR_OF_DAY)
              + ":" + cal.get(cal.MINUTE);
	}
	
	 public static List<String> get5MinutesListByCurrentDate(long length) {
		  List<String> dateList = new ArrayList<String>();
		  Calendar calendar = Calendar.getInstance();
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");//时间格式 
		  int minute = calendar.get(Calendar.MINUTE);// 得到分钟
		  int count = 0;
		  if (minute != 0 && minute != 5 && minute != 10 && minute != 15 && minute != 20 && minute != 25 && minute != 30 && minute != 35 
				 && minute != 40 && minute != 45 && minute != 50 && minute != 55 ) { //时间不为00，15，30，45的情况
		   for (int i = minute; i >= 0; i--) { //判断距离最近的00，15，30，45的分钟数
		    if (i % 5 == 0) {
		     break;
		    } else {
		     count++;
		    }
		   }
		  }
		  String Smonth="";
		  String Sday="";
		  String Shour="";
		  String Smi = "";
		  calendar.add(Calendar.MINUTE, -count); //获取最近的分钟
		  int year = calendar.get(Calendar.YEAR); //得到年
		  int month = calendar.get(Calendar.MONTH) + 1; //得到月
		  if(month<10){Smonth = "0"+month;}else{Smonth = month+"";}
		  int day = calendar.get(Calendar.DAY_OF_MONTH);// 得到天
		  if(day<10){Sday = "0"+day;}else{Sday = day+"";}
		  int hour = calendar.get(Calendar.HOUR_OF_DAY);// 得到小时
		  if(hour<10){ Shour = "0"+hour;}else{Shour = hour+"";}
		  int mi = calendar.get(Calendar.MINUTE);// 得到分钟
		  if(mi<10){ Smi = "0"+mi;}else{Smi = mi+"";}
		  String date = "";
		  
		   date = year + Smonth + Sday + Shour + "" + Smi; //月分0-9，转换为0开头
		    
		  date += "00"; //加秒
		  try {
		   long millionSeconds = sdf.parse(date).getTime(); // 时间转毫秒
		   System.out.println(sdf.format(millionSeconds)); //毫秒转时间
		   
		   
		   for (long i = 0; i < length; i++) {
		    dateList.add(String.valueOf(millionSeconds - i
		      * (5 * 60 * 1000)));
		   }
		  } catch (Exception e) {
		   e.printStackTrace();
		  }
		  GregorianCalendar gc = new GregorianCalendar();
		  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  ArrayList<String> realDataList = new ArrayList<String>();
		  for(int i=0;i<dateList.size();i++){
			  Date dat = new Date(Long.valueOf(dateList.get(i)));
			  gc.setTime(dat);
			  String sb=format.format(gc.getTime());  
			  //System.out.println("ss"+sb);
			  realDataList.add(sb);
		  }
		  
		  ArrayList<String> realDataListRet = new ArrayList<String>();
		  for(int i=realDataList.size()-1;i>=0;i--){
			  realDataListRet.add(realDataList.get(i));
		  }
		  
		  return realDataListRet;
		  
		 }
	 
	    
	    public static GregorianCalendar NextDateTimeSecond(int second, GregorianCalendar cal) {
	        int qsn = cal.get(Calendar.YEAR);
	        int qsy = cal.get(Calendar.MONTH) + 1;
	        int qsr = cal.get(Calendar.DATE);
	        int qss = cal.get(Calendar.HOUR_OF_DAY);
	        int qsf = cal.get(Calendar.MINUTE);
	        int qsm = cal.get(Calendar.SECOND);
	        GregorianCalendar nextDateTime = (GregorianCalendar) cal.clone();
	        nextDateTime.add(Calendar.SECOND, second);
	        return nextDateTime;
	    }

	    public static String formatGregorianCalendar(GregorianCalendar retTime){
	    	int year = retTime.get(GregorianCalendar.YEAR);
	        int month = retTime.get(GregorianCalendar.MONTH) + 1;
	        int day = retTime.get(GregorianCalendar.DAY_OF_MONTH);
	        int hour = retTime.get(GregorianCalendar.HOUR_OF_DAY);
	        int min = retTime.get(GregorianCalendar.MINUTE);
	        int sec = retTime.get(GregorianCalendar.SECOND);
	        int msec = retTime.get(GregorianCalendar.MILLISECOND);

	        String strVal = formatStr(year, 4) + "/" + formatStr(month, 2) + "/" + formatStr(day, 2) + " " + formatStr(hour, 2) + ":" + formatStr(min, 2) + ":" + formatStr(sec, 2) + "." + formatStr(msec, 3);
	        return strVal;
	    }

	    /***************************************************************************
	     * 功能：把整数 i 前补 0 至 len 长的字符串，如果 长度超过了 len ，不做处理直接返回 参数： v，被设置的值 len，长度 返回值：补
	     * 0 后的字符串
	     **************************************************************************/
	    public static String formatStr(int v, int len) {
	        String s = String.valueOf(v);
	        String r = s;

	        for (int i = s.length(); i < len; i++) {
	            r = "0" + r;
	        }

	        return r;
	    }
	    /**
	     * 将日期格式的String转成GregorianCalendar的日期
	     */
	    public static GregorianCalendar str2GregorianCalendar(String datestr, String format){
	    	Date date = DateUtil.parseDateStr(datestr, format);
	    	GregorianCalendar calendar = new GregorianCalendar();
	    	calendar.setTime(date);
	    	return calendar;
	    }
	    
	    /**
	     * 返回某个月的天数，不能比当前年的月份大
	     * @param year
	     * @param month
	     */
	    public static int getDaysForMonth(String year, String month){
	    	String daysFor31 = ",1,3,5,7,8,10,12,";
	    	
	    	Date date = new Date();
	    	int curMon = date.getMonth() + 1;
	    	int curYear = date.getYear() + 1900;
	    	if(curYear <= Integer.parseInt(year) && curMon <= Integer.parseInt(month)){
	    		if(curYear == Integer.parseInt(year) && curMon == Integer.parseInt(month)){
		    		return date.getDate();
		    	}else{
		    		return 0;
		    	}
	    	}
	    	
	    	if(daysFor31.indexOf("," + month + ",") >= 0){
	    		return 31;
	    	}else if("2".equals(month)){//2月
	    		if((Integer.parseInt(year) % 4 == 0 && Integer.parseInt(year) % 100 != 0)
		    			|| Integer.parseInt(year) % 400 == 0){ //闰年
		    		return 29;
		    	}else{ //平年
		    		return 28;
		    	}
	    	}else{
	    		return 30;
	    	}
	    }
	    /**
		 * 把字符串转化为时间
		 * yyyyMMdd_HH:mm:ss
	     * @throws ParseException 
	     */
	    public static Date getDate(String date) throws ParseException{
	    	String newDate = date.split("_")[0] + " " + date.split("_")[1];
	    	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	    	
	    	Date currentTime_1 = new Date();
			currentTime_1 = formatter.parse(newDate);
			return currentTime_1;
	    }
	    
	    /**
		 * 把字符串转化为时间
		 * yyyy-MM-dd HH:mm:ss
	     * @throws ParseException 
	     */
	    public static Date getDate(String date, String format) throws ParseException{
	    	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(format);
	    	Date currentTime_1 = new Date();
			currentTime_1 = formatter.parse(date);
			return currentTime_1;
	    }
}
