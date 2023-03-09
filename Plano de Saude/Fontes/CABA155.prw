//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
 
//Variáveis Estáticas
Static cTitulo := "Cadastro de campanhas - PA"
 
User Function CABA155()
    Local aArea   := GetArea()
    Local oBrowse
    Local cFunBkp := FunName()
     
    SetFunName("CABA155")

    oBrowse := FWMBrowse():New()

    oBrowse:SetAlias("PDE")

    oBrowse:SetDescription(cTitulo)
     
    //Legendas
    oBrowse:AddLegend( "PDE->PDE_ATIVO = .T. ", "GREEN",    "Habilitado" )
    oBrowse:AddLegend( "PDE->PDE_ATIVO = .F. ", "RED",    "Desabilitado" )
     
    //Filtrando
    //oBrowse:SetFilterDefault("ZZ1->ZZ1_COD >= '000000' .And. ZZ1->ZZ1_COD <= 'ZZZZZZ'")
    oBrowse:Activate()
    
    SetFunName(cFunBkp)
    RestArea(aArea)
Return Nil
 

 
Static Function MenuDef()
    Local aRot := {}
    //Adicionando opções
    ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.CABA155' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.CABA155' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.CABA155' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.CABA155' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
    ADD OPTION aRot TITLE 'Habilitar/Desabilitar'    ACTION 'CABA155A' OPERATION 6 ACCESS 0
Return aRot
 
 
Static Function ModelDef()

    Local oModel := Nil

    Local oStPDE := FWFormStruct(1, "PDE")

    oStPDE:SetProperty('PDE_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edição
    oStPDE:SetProperty('PDE_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("PDE", "PDE_COD")'))         //Ini Padrão
    oStPDE:SetProperty('PDE_REGRA',  MODEL_FIELD_VALID,   FwBuildFeature(STRUCT_FEATURE_VALID,   'Iif(Empty(M->PDE_REGRA), .F., .T.)'))   //Validação de Campo
    oStPDE:SetProperty('PDE_ATIVO',  MODEL_FIELD_INIT,   FwBuildFeature(STRUCT_FEATURE_INIPAD,   '.T.'))

    oModel := MPFormModel():New("MODELPDE",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 

    oModel:AddFields("PDEMASTER",/*cOwner*/,oStPDE)

    oModel:SetPrimaryKey({'PDE_FILIAL','PDE_COD'})
 
    oModel:SetDescription(cTitulo)

    oModel:GetModel("PDEMASTER"):SetDescription(cTitulo)

Return oModel
 
 
Static Function ViewDef()
     
    Local oModel := ModelDef() 
     
    Local oStPDE := FWFormStruct(2, "PDE")  //pode se usar um terceiro parâmetro para filtrar os campos exibidos { |cCampo| cCampo $ 'SZZ1_NOME|SZZ1_DTAFAL|'}
     
    Local oView := FWFormView():New()

    oView:SetModel(oModel)
     
    oView:AddField("VIEW_PDE", oStPDE, "PDEMASTER")
     
    oView:CreateHorizontalBox("TELA",100)
     
    oView:EnableTitleView('VIEW_PDE', cTitulo )  
     
    oView:SetCloseOnOk({||.T.})

    oView:SetOwnerView("VIEW_PDE","TELA")
       
Return oView

 