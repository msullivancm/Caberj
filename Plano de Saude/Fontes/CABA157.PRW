//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
 
//Variáveis Estáticas
Static cTitulo := "Relacionamento SLA entre Areas"
 
User Function CABA157()

    Local aArea   := GetArea()

    Local oBrowse

    Local cFunBkp := FunName()
     
    SetFunName("CABA157")

    oBrowse := FWMBrowse():New()

    oBrowse:SetAlias("PDF")

    oBrowse:SetDescription(cTitulo)
 
    oBrowse:Activate()
    
    SetFunName(cFunBkp)

    RestArea(aArea)

Return Nil
 

 
Static Function MenuDef()
    Local aRot := {}
    //Adicionando opções
    ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.CABA157' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.CABA157' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.CABA157' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.CABA157' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5

Return aRot
 
 
Static Function ModelDef()

    Local oModel 

    Local oStPDF := FWFormStruct(1, "PDF")

    oModel := MPFormModel():New("MODELPDF",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 

    oModel:AddFields("PDFMASTER",/*cOwner*/,oStPDF)

    oModel:SetPrimaryKey({})
 
    oModel:SetDescription(cTitulo)

    oModel:GetModel("PDFMASTER"):SetDescription(cTitulo)

Return oModel
 
 
Static Function ViewDef()
     
    Local oModel := FwLoadModel("CABA157")
     
    Local oStPDF := FWFormStruct(2, "PDF")  //pode se usar um terceiro parâmetro para filtrar os campos exibidos { |cCampo| cCampo $ 'SZZ1_NOME|SZZ1_DTAFAL|'}

    Local oView := FWFormView():New()

    oView:SetModel(oModel)
     
    oView:AddField("VIEW_PDF", oStPDF, "PDFMASTER")
     
    oView:CreateHorizontalBox("TELA",100)
     
    //oView:EnableTitleView('VIEW_PDF', cTitulo )  
     
    //oView:SetCloseOnOk({||.T.})

    oView:SetOwnerView("VIEW_PDF","TELA")
       
Return oView

 