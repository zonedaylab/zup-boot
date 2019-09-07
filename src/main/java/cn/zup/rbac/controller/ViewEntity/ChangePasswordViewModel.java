package cn.zup.rbac.controller.ViewEntity;

public class ChangePasswordViewModel
{

	private String oldPassword;	
	private String newassword;	
	private String confirmPassword;
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public String getNewassword() {
		return newassword;
	}
	public void setNewassword(String newassword) {
		this.newassword = newassword;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
}
