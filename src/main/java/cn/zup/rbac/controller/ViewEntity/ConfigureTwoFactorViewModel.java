package cn.zup.rbac.controller.ViewEntity;

import java.util.Collection;

import javax.faces.model.SelectItem;

public class ConfigureTwoFactorViewModel
{
	private String selectedProvider;	
	
	//private Collection<System.Web.Mvc.SelectListItem> providers;	
	private Collection<SelectItem> providers;
	
	public String getSelectedProvider() {
		return selectedProvider;
	}
	public void setSelectedProvider(String selectedProvider) {
		this.selectedProvider = selectedProvider;
	}
	public Collection<SelectItem> getProviders() {
		return providers;
	}
	public void setProviders(Collection<SelectItem> providers) {
		this.providers = providers;
	}
	
	
	
}
