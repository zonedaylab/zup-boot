package cn.zup.wechat.entity;

public class TicketInTokenEntity {
	private Integer expire_seconds = null; //该二维码有效时间，以秒为单位。 最大不超过2592000（即30天），此字段如果不填，则默认有效期为30秒。
	private String action_name = "QR_LIMIT_SCENE"; //二维码类型，QR_SCENE为临时的整型参数值，QR_STR_SCENE为临时的字符串参数值，QR_LIMIT_SCENE为永久的整型参数值，QR_LIMIT_STR_SCENE为永久的字符串参数值
	private ActionInfo action_info; //	二维码详细信息
	
	public Integer getExpire_seconds() {
		return expire_seconds;
	}

	public void setExpire_seconds(Integer expire_seconds) {
		this.expire_seconds = expire_seconds;
	}

	public String getAction_name() {
		return action_name;
	}

	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}

	public ActionInfo getAction_info() {
		return action_info;
	}

	public void setAction_info(ActionInfo action_info) {
		this.action_info = action_info;
	}

	public class ActionInfo {
		private Scene scene;

		public Scene getScene() {
			return scene;
		}

		public void setScene(Scene scene) {
			this.scene = scene;
		}
		
	}
	
	public class Scene {
		private Integer scene_id;
		private String scene_str;
		public Integer getScene_id() {
			return scene_id;
		}
		public void setScene_id(Integer scene_id) {
			this.scene_id = scene_id;
		}
		public String getScene_str() {
			return scene_str;
		}
		public void setScene_str(String scene_str) {
			this.scene_str = scene_str;
		}
		
	}
	
	public class Result {
		private String ticket;
		private String url;
		public String getTicket() {
			return ticket;
		}
		public void setTicket(String ticket) {
			this.ticket = ticket;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
	}
}
