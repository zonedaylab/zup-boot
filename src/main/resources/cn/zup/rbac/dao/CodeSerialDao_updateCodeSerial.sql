update codeserial set codeType='${codeserial.codeType}'
<#if codeserial.serial ?exists>
	, serial = ${codeserial.serial}
</#if>
where codeType='${codeserial.codeType}'