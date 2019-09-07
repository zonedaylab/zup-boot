package cn.zup.rbac.controller.ViewEntity;

import java.util.List;

public class IndexViewModel
{
	private boolean hasPassword;	
	//private List<UserLoginInfo> logins;
	private String phoneNumber;
	private boolean twoFactor;
	private boolean browserRemembered;
	public boolean isHasPassword() {
		return hasPassword;
	}
	public void setHasPassword(boolean hasPassword) {
		this.hasPassword = hasPassword;
	}
//	public java.util.List<UserLoginInfo> getLogins() {
//		return logins;
//	}
//	public void setLogins(java.util.List<UserLoginInfo> logins) {
//		this.logins = logins;
//	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public boolean isTwoFactor() {
		return twoFactor;
	}
	public void setTwoFactor(boolean twoFactor) {
		this.twoFactor = twoFactor;
	}
	public boolean isBrowserRemembered() {
		return browserRemembered;
	}
	public void setBrowserRemembered(boolean browserRemembered) {
		this.browserRemembered = browserRemembered;
	}
	
}
