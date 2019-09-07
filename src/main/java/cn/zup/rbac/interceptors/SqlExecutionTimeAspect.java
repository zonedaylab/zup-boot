package cn.zup.rbac.interceptors;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

/**
 * 对Spring JdbcTemplate进行切面，记录每个sql执行时间。
 */
@Aspect
public class SqlExecutionTimeAspect {
	/**
	 * logger
	 */
	private static final Logger LOG = Logger
			.getLogger(SqlExecutionTimeAspect.class);

	/**
	 * 当Sql执行时间超过该值时，则进行log warn级别题型，否则记录INFO日志。
	 */
	private long warnWhenOverTime = 2 * 60 * 1000L;

	@Around("execution(* org.springframework.jdbc.core.JdbcTemplate.*(..))")
	public Object logSqlExecutionTime(ProceedingJoinPoint joinPoint)
			throws Throwable {
		long startTime = System.currentTimeMillis();
		Object result = joinPoint.proceed();
		long costTime = System.currentTimeMillis() - startTime;
		if (costTime > warnWhenOverTime) {
			StringBuilder sb = new StringBuilder();
			sb.append("execute method :").append(joinPoint.getSignature());
			sb.append("args: ").append(arrayToString(joinPoint.getArgs()));
			sb.append(" cost time[").append(costTime).append("]ms");
			LOG.warn(sb);
		} else if (LOG.isInfoEnabled()) {
			StringBuilder sb = new StringBuilder();
			sb.append("execute method :").append(joinPoint.getSignature());
			sb.append("args: ").append(arrayToString(joinPoint.getArgs()));
			sb.append(" cost time[").append(costTime).append("]ms");
			LOG.info(sb);
		}
		System.out.println("进入aop-sql监听");
		return result;
	}

	private static String arrayToString(Object[] a) {
		if (a == null)
			return "null";

		int iMax = a.length - 1;
		if (iMax == -1)
			return "[]";

		StringBuilder b = new StringBuilder();
		b.append('[');
		for (int i = 0;; i++) {
			if (a[i] instanceof Object[]) {
				b.append(arrayToString((Object[]) a[i]));
			} else {
				b.append(String.valueOf(a[i]));
			}
			if (i == iMax)
				return b.append(']').toString();
			b.append(", ");
		}
	}
}