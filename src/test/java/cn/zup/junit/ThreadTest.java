package cn.zup.junit;


public class ThreadTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 TestSync runner = new TestSync();
	        Thread one = new Thread(runner);
	        Thread two = new Thread(runner);
	        one.setName("1");
	        two.setName("2");
	        one.start();
	        two.start();
	}
}