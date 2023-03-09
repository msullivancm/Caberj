#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'

User Function CABA361
Local aArea         := GetArea()
Local oBrowse         := FwMBrowse():New()
Private cCadastro     := 'Cadastro de pacotes'
Private aRotina        := MenuDef() 

    oBrowse:SetAlias('PDO')
    oBrowse:OptionReport(.F.)
    oBrowse:SetDescription(cCadastro)
    oBrowse:AddLegend("empty(PDO_YVIGFI) ", 'GREEN'    , 'Competência em Aberto')
    oBrowse:AddLegend("!empty(PDO_YVIGFI)", 'RED', 'Competência Fechada')
    oBrowse:Activate()

    RestArea(aArea)

Return 

Static Function MenuDef()
Local aRotina := {}

    Add Option aRotina Title 'Pesquisar'         Action 'AxPesqui'               Operation 1 Access 0
    Add Option aRotina Title 'Visualizar'         Action 'VIEWDEF.CABA361'     Operation 2 Access 0
    Add Option aRotina Title 'Incluir'             Action 'VIEWDEF.CABA361'     Operation 3 Access 0
    Add Option aRotina Title 'Alterar'             Action 'VIEWDEF.CABA361'     Operation 4 Access 0
    Add Option aRotina Title 'Excluir'             Action 'VIEWDEF.CABA361'     Operation 5 Access 0
    Add Option aRotina Title 'Imprimir'         Action 'VIEWDEF.CABA361'     Operation 8 Access 0

Return(aRotina)

Static Function ModelDef
Local oModel     := Nil
Local oStruHead    := FwFormStruct(1,'PDO')
Local oStruGrid := FwFormStruct(1,'PDP')

	oStruHead:addTrigger( 'PDO_CODPRO','PDO_DESPRO',{|| .T.} , {|oModel| U_zAplica(oModel)})
	
	oStruGrid:addTrigger( 'PDP_CODOPC','PDP_DESOPC',{|| .T.} , {|oModel| U_zAplica2(oModel)})
	
   //Monta o modelo principal
    oModel    := MpFormModel():New('CCFMVC')//,/*Pre-Validacao*/,/*Validação*/,/*Pós-Validação*/)
    oModel:SetDescription(cCadastro)  
                                    	
    //Monta os dados do cabeçalho
    oModel:AddFields('ModelHead',,oStruHead)
    oModel:SetPrimaryKey({'PDO_FILIAL','PDO_CODINT','PDO_CODPAD','PDO_CODPRO'})                                                                                                                   

    oModel:GetModel('ModelHead'):SetDescription(cCadastro)

    oStruHead:SetProperty('PDO_CODPAC', MODEL_FIELD_WHEN, {|| INCLUI})
    oStruHead:SetProperty('PDO_CODPRO', MODEL_FIELD_WHEN, {|| INCLUI})

    //Monta os dados dos itens
    oModel:AddGrid('ModelGrid','ModelHead',oStruGrid,,{|oGrid| fLinOK(oGrid)},/*bPreGrid*/,/*bProsGrid*/)

    oModel:SetRelation('ModelGrid',{{'PDP_FILIAL','PDO_FILIAL'},{'PDP_CODINT','PDO_CODINT'},{'PDP_CODPAD','PDO_CODPAD'},{'PDP_CODPRO','PDO_CODPRO'}}, PDP->(IndexKey(1)) )
        
    oModel:GetModel('ModelGrid'):SetDescription('Itens')        
    oModel:GetModel('ModelGrid'):SetDelAllLine(.T.)
    oModel:GetModel('ModelGrid'):SetOptional(.F.)
  
   
Return(oModel)

Static Function ViewDef
Local oView        := Nil
Local oModel    := FwLoadModel('CABA361') 
Local oStruHead    := FwFormStruct(2,'PDO')
Local oStruGrid := FwFormStruct(2,'PDP')

    //Não exibe o folder visual caso algum campo esteja inserido em um
    oStruHead:SetNoFolder()

    oView:= FwFormView():New() 
    oView:SetModel(oModel)              

    //Crio o cabeçalho e os grids de acordo com o modelo
    oView:AddField('ViewHead', oStruHead, 'ModelHead')
    oView:AddGrid ('ViewGrid', oStruGrid, 'ModelGrid')

    //Crio uma layer com 30% da tela e outra com 70% da tela, similar a FwLayer
    oView:CreateHorizontalBox('MAIN',40)
    oView:CreateHorizontalBox('GRID',60)

    //Informo os devidos títulos das telas
    oView:EnableTitleView('ViewHead','Pacote')
    oView:EnableTitleView('ViewGrid','Itens pacote')

    //Informo a porcentagem da tela que cada view deve ocupar
    oView:SetOwnerView('ViewHead','MAIN')
    oView:SetOwnerView('ViewGrid','GRID')

Return(oView)

Static Function fLinOK(oGrid)
Local oModel      := FwModelActive()

    oGrid:GoLine(oGrid:nLine)
Return .T.

User function zAplica(oModel)
	Local cQry := ''
	local cPad := oModel:GetValue("PDO_CODPAD")
	local cPro := oModel:GetValue("PDO_CODPRO")
	local cret := ''
	
	cQry += " SELECT BR8_DESCRI FROM "+RetSqlName("BR8")+" WHeRE BR8_CODPAD = '"+cPad+"' AND BR8_CODPSA = '"+cPro+"' AND D_E_L_E_T_ = ' ' "
	
	cAliasBR8 := MpSysOpenQuery(cQry)
	If (cAliasBR8)->(!Eof())
		cret := (cAliasBR8)->BR8_DESCRI
	EndIf

return SUBSTR(cret,1,40)

User function zAplica2(oModel)
	Local cQry := ''
	local cPad := oModel:GetValue("PDP_CPADOC")
	local cPro := oModel:GetValue("PDP_CODOPC")
	local cret := ''
		
	cQry += " SELECT BR8_DESCRI FROM "+RetSqlName("BR8")+" WHeRE BR8_CODPAD = '"+cPad+"' AND BR8_CODPSA = '"+cPro+"' AND D_E_L_E_T_ = ' ' "
	
	cAliasBR8 := MpSysOpenQuery(cQry)
	If (cAliasBR8)->(!Eof())
		cret := (cAliasBR8)->BR8_DESCRI
	EndIf

return SUBSTR(cret,1,40)
////////////////////
User function vldproc(opc)
	Local cQry := ''
	/*local cPad := FWFldGet("PDO_CODPAD")	
	local cPro := FWFldGet("PDO_CODPRO")*/
	local cPad := ''
	local cPro := ''
	local lRet := .T.
	
	If opc == 1
		cPad := FWFldGet("PDO_CODPAD")	
	    cPro := FWFldGet("PDO_CODPRO")
		cQry += "SELECT count (*) qtd FROM "+RetSqlName("PDO")+" WHERE D_E_L_E_T_ =' ' and PDO_CODPAD = '"+cPad+"' AND PDO_CODPRO = '"+cPro+"' and PDO_YVIGFI=' '"
		
		cAliasPDO := MpSysOpenQuery(cQry)
			
		if (cAliasPDO)->qtd <> 0 
		     
		     MsgInfo("Pacote já cadastrado")
		     lRet := .F.	     	
		EndIf
	Else
		cPadPct := FWFldGet("PDP_CPADOC")	
	    cPct	:= FWFldGet("PDP_CODOPC")
	    cPro 	:= FWFldGet("PDO_CODPRO")
	    cPad 	:= FWFldGet("PDO_CODPAD")
		cQry += "SELECT count (*) qtd FROM "+RetSqlName("PDP")+" WHERE D_E_L_E_T_ =' ' and PDP_CODPAD = '"+cPad+"' AND PDP_CODPRO = '"+cPro+"' and PDP_CPADOC = '"+cPadPct+"' AND PDP_CODOPC = '"+cPct+"' and PDP_VIGATE=' '"
		
		cAliasPDP := MpSysOpenQuery(cQry)
			
		if (cAliasPDP)->qtd <> 0 
		     
		     MsgInfo("Esse pacote já possui este procedimento")
		     lRet := .F.	     	
		EndIf
	
	EndIf 

return lRet


