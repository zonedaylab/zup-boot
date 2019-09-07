package cn.zup.rbac.controller;

import antlr.collections.List;
import cn.zup.rbac.entity.Organ;
import cn.zup.rbac.service.OrganPostService;
public class SystemPublicController 
//extends Controller
{
//	
//	public final ActionResult Index()
//	{
//		return View();
//	}
//	/** 
//	 组织部门公共页面
//	 调用示例
//	 ../../Public/OrganTree
//	 dev panw
//	 
//	 @return 
//	*/
//	public final ActionResult OrganSelect()
//	{
//		Ext.Net.MVC.PartialViewResult tempVar = new Ext.Net.MVC.PartialViewResult();
//		tempVar.ViewName = "_OrganTree";
//		return tempVar;
//	}
//
//	public final ActionResult OrganTree(String node)
//	{
//		if (node.equals("Root"))
//		{
//			NodeCollection organTree = InitOrganTree();
//			return Content(organTree.ToJson());
//		}
//		return new HttpStatusCodeResult((int)System.Net.HttpStatusCode.BadRequest);
//	}
//	/** 
//	 初始化组织机构树
//	 dev panw
//	 
//	 @return 
//	*/
//	private NodeCollection InitOrganTree()
//	{
//		NodeCollection nodeCollectionOrganTree = new NodeCollection();
//		
//		OrganPostService OrganPost =new OrganPostService();
//		List<Organ> rootOrganList = OrganPost.SubOrganList(0);
//		LoadSubOrganTree(nodeCollectionOrganTree, rootOrganList);
//		return nodeCollectionOrganTree;
//	}
//
//	/** 
//	 加载组织机构子节点
//	 dev panw
//	 
//	 @param nodeCollection
//	 @param currentOrganList
//	*/
//	private void LoadSubOrganTree(NodeCollection nodeCollection, Iterable<Zone.Rbac.Entities.Organ> currentOrganList)
//	{
//		IOrganPost OrganPost = Zone.Rbac.Client.InstanceManager.ServiceProxy.OrganPostService();
//		Node node;
//		Iterable<Zone.Rbac.Entities.Organ> nextOrganList;
//		for (var organ : currentOrganList)
//		{
//			node = new Node();
//			node.NodeID = organ.OrganID.toString();
//			node.setText(organ.OrganName);
//			nextOrganList = OrganPost.SubOrganList(organ.OrganID);
//			if (nextOrganList.Count().equals(0))
//			{
//				node.Leaf = true;
//			}
//			else
//			{
//				node.Leaf = false;
//			}
//			LoadSubOrganTree(node.Children, nextOrganList);
//			nodeCollection.Add(node);
//		}
//	}
//
//	/** 
//	 树节点异步加载
//	 dev panw
//	 
//	 @param node
//	 @return 
//	*/
//	public final ActionResult NodeLoad(String node)
//	{
//		NodeCollection nodes = new Ext.Net.NodeCollection();
//		IOrganPost OrganPost = Zone.Rbac.Client.InstanceManager.ServiceProxy.OrganPostService();
//		if (!DotNetToJavaStringHelper.isNullOrEmpty(node))
//		{
//			List<Organ> rootOrganList = OrganPost.SubOrganList(Integer.parseInt(node));
//			for (var organ : rootOrganList)
//			{
//				Node asyncNode = new Node();
//				asyncNode.setText(organ.OrganName);
//				asyncNode.NodeID = organ.OrganID.toString();
//				nodes.Add(asyncNode);
//			}
//		}
//		return this.Direct(nodes);
//	}
//	/** 
//	 打印主体载体页面
//	 
//	 @param Parameters 提供的action参数
//	 @param TemplatGrf 提供模板的位置
//	 @return 
//	*/
//	 public final ActionResult PrintTemp(String Parameters, String TemplatGrf)
//	{
//
//		Parameters = Server.UrlEncode(Parameters);
//		ViewBag.Parameters = Parameters;
//		ViewBag.TemplatGrf = TemplatGrf;
//		return View();
//	}
//	 public final ActionResult WaterPrintTemp(String Parameters, String TemplatGrf)
//	 {
//		 Zone.Biz.Test.Store.WaterTestStore<Zone.Biz.Test.Entities.TestPoint> testPointService = new Biz.Test.Store.WaterTestStore<Biz.Test.Entities.TestPoint>();
//
//		 Parameters = Server.UrlEncode(Parameters);
//		 ViewBag.Parameters = Parameters;
//		 ViewBag.TemplatGrf = TemplatGrf;
//
//		 java.util.List<TestPoint> testPoint = testPointService.List(o => o.OrganID == UserContext.Current.UserSession.OrganID);
//		 ViewData["PointList"] = new SelectList(testPoint, "PointID", "PointName");
//		 ;
//		 return View();
//	 }
}
