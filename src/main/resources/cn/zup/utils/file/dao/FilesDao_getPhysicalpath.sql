select physicalpath from 
  ( 
 select concat(file_package.physicalpath,file_virtual.PHYSICALNAME) as physicalpath,fiLE_VIRTUAL.VIRTUALFILEID from files
 join file_virtual on file_virtual.fileid=files.fileid
 join file_package on file_package.filepackageid=files.filepackageid
 where 1=1 
	<#if businessKey ?exists>
	and businessKey='${businessKey}' 
	</#if>
	<#if packageId ?exists>
	and file_package.filepackageId=${packageId} 
	</#if> 
	order by fiLE_VIRTUAL.VIRTUALFILEID desc )a
 where @rownum:=1 