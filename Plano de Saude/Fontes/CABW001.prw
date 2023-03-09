#Define CRLF Chr(13)+Chr(10)
#Include "Protheus.Ch"
#INCLUDE "MSOLE.CH"
#Include "TbiConn.Ch"
#Include  "FONT.CH"
#Include "TOPCONN.CH"
#INCLUDE "TCBrowse.ch"

#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

***********************
User Function CABW001()
***********************

Private oFntAri13N :=  TFont():New( "Arial"       ,,-13,,.F.,,,,,.F. )
Private oFntAri11N :=  TFont():New( "Arial"       ,,-11,,.F.,,,,,.F. )

Private cAlias      := "BAU"
Private aButtons    := {}
Private cAliasTmp   := "__Tmp"
Private _cRdaDe     := Space(06)
Private _cRdaAte    := Space(06)
Private _cEspeDe    := Space(03)
Private _cEspeAte   := Space(03)
//Private _cLocalDe := Space(03)
//Private _cLocalAte:= Space(03)
Private _cPathArq   := Space(40)
Private lImp        := .T.
Private bOk         := {|| fConsulta()}
Private bCancel     := {|| oDlgWord:End()}
Private oBmp        := NIL
Private oDlgWord    := NIL
Private cExt        := "Arquivos Word|*.DOT| Todos os Arquivos|*.*"
Private oRadio := Nil
Private nRadio := 1

oDlgWord:=TDialog():New(000,000,360,425,"Gera��o de contratos ",,,,,,,,,.T.)
oDlgWord:nClrPane:= RGB(255,255,254)
oDlgWord:bStart  := {||(EnchoiceBar(oDlgWord,bOk,bCancel,,aButtons))}

oGrp1 := TGROUP():New (020, 008, 050, 200, OemToAnsi ("Rede de Atendimento "), oDlgWord, 0, 0, .T., .T.)
oSay01 := TSay():New(030,010,{|| " De ? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,025,10)
oSay02 := TSay():New(030,105,{|| " Ate? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,035,10)
oGet01 := TGet():New(030,040,bSetGet(_cRdaDe    ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAUPLS","cRdade" )
oGet02 := TGet():New(030,140,bSetGet(_cRdaAte   ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAUPLS","cRdaAte" )

oGrp2 := TGROUP():New(055, 008, 085, 200, OemToAnsi ("Especialidades"), oDlgWord, 0, 0, .T., .T.)
oSay03 := TSay() :New(065,010,{|| " De ? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,080,10)
oSay04 := TSay() :New(065,105,{|| " Ate? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,080,10)
oGet03 := TGet() :New(065,040,bSetGet(_cEspeDe   ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAQ"   ,"cEspeDe ")
oGet04 := TGet() :New(065,140,bSetGet(_cEspeAte  ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAQ"   ,"cEspeAte")
/*
oGrp3 := TGROUP():New (090, 008, 115, 200, OemToAnsi ("Local de Atendimento"), oDlgWord, 0, 0, .T., .T.)
oSay05 := TSay():New(100,010,{|| " De ? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,080,10)
oSay06 := TSay():New(100,095,{|| " Ate? "                 },oDlgWord,,oFntAri13N,,,,.T.,,,080,10)
oGet05 := TGet():New(100,040,bSetGet(_cLocalDe  ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAX"   ,"cLocalDe")
oGet06 := TGet():New(100,140,bSetGet(_cLocalAte ) ,oDlgWord,050,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,"BAX"   ,"cLocalAte")
*/
oGrp3  := TGROUP():New (090, 008, 135, 200, OemToAnsi ("Modelo do Contrato"), oDlgWord, 0, 0, .T., .T.)
oSay07 := TSay():New(100,015,{|| " Local do Arquivo "                 },oDlgWord,,oFntAri13N,,,,.T.,,,080,10)
oGet07 := TGet():New(110,015,bSetGet(_cPathArq  ) ,oDlgWord,150,10,"" ,{||.T.  },,,oFntAri13N,,,.T.,,,{||.T.},,,,.F.,,,"cParhArq")
@ 110,170 BUTTON "..." SIZE  13,13 PIXEL OF oDlgWord ACTION _cPathArq := AllTrim(cGetFile(cExt,"Arquivo a Importar",,,.T.,1))

oGrp4 := TGROUP():New (140,008,175, 200, OemToAnsi ("Opcao de Saida" ), oDlgWord, 0, 0, .T., .T.)
@ 150,015 RADIO oRadio VAR nRadio 3D SIZE 60, 11 PROMPT "Imprime ","Gera Arquivo" of oDlgWord PIXEL

oDlgWord:Activate(,,,.T.)

Return(.T.)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fConsulta �Autor  �Microsiga           � Data �  10/31/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

****************************
Static function fConsulta()
****************************

Local lRet     := .T.
Local cQuery   := " "

cQuery := " SELECT * FROM " +  RetSqlName("BAU")+ " BAU ," +  RetSqlName("BC9")+ " BC9 "
cQuery += " WHERE  BAU.D_E_L_E_T_ = ' ' AND BC9.D_E_L_E_T_ = ' ' "

If !Empty(_cRdaAte)
	cQuery += " AND BAU_CODIGO BETWEEN '" +_cRdaDe + "'  AND  '" + _cRdaAte + "' "
Endif
//cQuery += " AND BAU_MUN = BC9_CODMUN AND BAU_CEP = BC9_CEP" 
cQuery += " AND BAU_CEP = BC9_CEP" 
//If !Empty(_cEspeAte)
//	cQuery += " AND BAX.BAX_CODIGO BETWEEN '" + _cEspeDe + "'  AND '" + _cEspeAte + "'"
//Endif

//If !Empty(_cLocalAte)
//	cQuery += " AND BAX.BAX_CODLOC BETWEEN '" + _cLocalDe + "'  AND '" + _cLocalAte + "'"
//Endif

//cQuery += " AND BAX.BAX_CODIGO = BAU.BAU_CODIGO "
//cQuery += " AND BAX.BAX_CODESP = BAQ.BAQ_CODESP "

cQuery := ChangeQuery(cQuery)

If Select(cAliasTmp) <> 0 ; (cAliasTmp)->(DbCloseArea()) ; Endif
DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)
/*
For ni := 1 to Len(aStruct)
If aStruct[ni,2] != 'C'
TCSetField(cAliasTmp, aStruct[ni,1], aStruct[ni,2],aStruct[ni,3],aStruct[ni,4])
Endif
Next
*/
cTmp2 := CriaTrab(NIL,.F.) //CriaTrab(aStruct,.T.)
Copy To &cTmp2

dbCloseArea()

dbUseArea(.T.,,cTmp2,cAliasTmp,.T.)

DbSelectArea(cAliasTmp)
(cAliasTmp)->(DbGoTop())

If (cAliasTmp)->(Eof())
	ApMsgInfo("N�o foram encontrados registros com os parametros informados !")
	lRet := .F.
Else
	MsgRun("Aguarde...","Gerando Contratos...",{|| fCtrWord(IIf(nRadio == 1 ,.T.,.F.))})
Endif

oDlgWord:End()
Return(lRet)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 �  fW001 � Autor �  Wellington Tonieto   � Data � 12/12/08   ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do WORD             		    					  		  ���
�������������������������������������������������������������������������Ĵ��
��� Uso	 	 � Especifico Caberj                                          ���
�������������������������������������������������������������������������Ĵ��
��� Revis�o  �								      	           � Data �          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function fCtrWord(lImprime)
Local nPos 	     := 0
Local cArqOri    := _cPathArq
Local aInfo      := {}
//Local cPathDot  := "M:\Protheus_Data\IntegracaoProtheusOffice\"   //Alltrim(GetMv("MV_PTWORD")) + cArq // PATH DO ARQUIVO MODELO WORD
Local cPathWrd   := SuperGetMv("MV_DIRWRD",,"C:\TOTVS_WORD\") //Alltrim(GetMv("MV_DIRWRD")) // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO
Local _cPraso    := SuperGetMv("MV_XPERCTR",,"12 Meses")
Local _cDiaPgt   := SuperGetMv("MV_XDIACTR",,"10" )
Local _cSede     := " "
Local _cEmp      := IIf(cEmpAnt == "01","'C'","'I'") //Caberj ou Integral
Local _cTpTabMed := " "
Local _cTpTabHos := " "

//�����������������������������������������������������������������������Ŀ
//�Busca a tabela de honorarios medicos a ser utilizada conforme a empresa|
//�������������������������������������������������������������������������

If  _cEmp == "C" //Caberj
	_cTpTabMed := SuperGetMv("MV_XTABELA",,"CIEFAS-96")
Else
	_cTpTabMed  := SuperGetMv("MV_XTABELA" ,,"AMB-92")
Endif

//�����������������������������������������������������������������������Ŀ
//�Busca dados da empresa atual                                           |
//�������������������������������������������������������������������������

IF !fInfo(@aInfo,cFilAnt,cEmpAnt)
	Alert(" Os dados da empresa selecionada nao foram localizados , favor entrar com contato com administrador do sistema " )
	Return
EndIF

//�����������������������������������������������������������������������Ŀ
//� Criando link de comunicacao com o word                                �
//�������������������������������������������������������������������������

hWord := OLE_CreateLink()
OLE_SetProperty ( hWord, oleWdVisible, .F.)

//�����������������������������������������������������������������������Ŀ
//� Seu Documento Criado no Word                                          �
//� A extensao do documento tem que ser .DOT                              �
//�������������������������������������������������������������������������

MontaDir(cPathWrd)

DbSelectArea(cAliasTmp)
DbGoTop()
While !(cAliasTmp)->(Eof())
	
	cArqDest := Alltrim((cAliasTmp)->BAU_NOME) + ".Dot"
	
	//�����������������������������������������������������������������������Ŀ
	//� Atualiza o Arquivo caso ele j� exista                                 �
	//�������������������������������������������������������������������������
	
	If File( cPathWrd    + cArqDest )
		Ferase( cPathWrd + cArqDest )
	EndIf
	
	//�����������������������������������������������������������������������Ŀ
	//� Copia Arquivo para Esta��o , conforme caminho informado no parametro  �
	//�������������������������������������������������������������������������
	
	__CopyFile(cArqOri,cPathWrd+cArqDest)
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando novo documento do Word na estacao                             �
	//�������������������������������������������������������������������������
	
	OLE_NewFile( hWord, cPathWrd + cArqDest)
	
	//�����������������������������������������������������������������������Ŀ
	//� Atribui Variaveis Iniciais de Cadastro                                �
	//�������������������������������������������������������������������������
	
  //	_cCnes   := (cAliasTmp)->BAU_CNES //Posicione("BB8",(cAliasTmp)->(xFilial("BAU") + BAU_CODIGO + BAU_CODOPE ),"BB8_CNES")  
  	_cCnes   := /*(cAliasTmp)->BAU_CNES */ Posicione("BB8",1,(cAliasTmp)->(xFilial("BAU") + BAU_CODIGO ),"BB8_CNES")
  	
  	if _cCnes = " "
  	   _cCnes := "x-x-x-x-x-x"
  	EndIf   
  	
  	If empty (trim((cAliasTmp)->(BAU_COMPL)))   
	   _cSede   := rtrim((cAliasTmp)->(BAU_END)) + " " + rtrim((cAliasTmp)->(BAU_NUMERO))+ " - " + rtrim((cAliasTmp)->(BAU_BAIRRO)) + " - " + rtrim((cAliasTmp)->(BC9_MUN)) + " , "+ rtrim((cAliasTmp)->(BAU_EST))
    Else
       _cSede   := rtrim((cAliasTmp)->(BAU_END)) + " " +rtrim((cAliasTmp)->(BAU_NUMERO))+ " " + rtrim((cAliasTmp)->(BAU_COMPL)) + " - " + rtrim((cAliasTmp)->(BAU_BAIRRO)) + " - " + rtrim((cAliasTmp)->(BC9_MUN)) + " , "+ rtrim((cAliasTmp)->(BAU_EST))    
    EndIf
 	_cDiaPgt := StrZero((cAliasTmp)->BAU_DIAPGT,2)
	_cEspec  := fBuscEspec((cAliasTmp)->BAU_CODIGO) //Busca as especialidades conforme informado nos parametros
	
	If (cAliasTmp)->BAU_TIPPE == "F"          
		_cIdent  := (cAliasTmp)->(BAU_CONREG + " - " + BAU_SIGLCR)
		_cCPfCgc     := (cAliasTmp)->BAU_CPFCGC
		_cRepresenta := (cAliasTmp)->BAU_NOME
		_cTipoPr     := "CPF"
	Else  
		_cIdent  := (cAliasTmp)->(BAU_DIRREG)
		_cCpfCgc     := (cAliasTmp)->BAU_YCPFDI
		_cRepresenta := (cAliasTmp)->BAU_DIRTEC
		_cTipoPr     := "CNPJ/MF"
	Endif
	
	if _cCPfCgc = " " 
	   _cCPfCgc := "x-x-x-x-x"
	EndIf   

	if _cIdent = " " 
	   _cIdent := "x-x-x-x-x"
	EndIf   

	
	//�����������������������������������������������������������������������Ŀ
	//� Busco os produtos do prestador - Obs: Funcao Customizada no Oracle    �
	//�������������������������������������������������������������������������
	
	cQuery := " SELECT PLS_RET_PRODUTOS_PREST(" //+ (cAliasTmp)->BAU_CODIGO
  	cQuery += "'"+(cAliasTmp)->BAU_CODIGO+"'" + "," + _cEmp  //"'"+_cEmp+"'" //Funcao nova -> Tem que passar a empresa como parametro.
	cQuery += " ) PRODUTOS FROM DUAL "   
	
	If Select("_Prod") <> 0
		DbSelectArea("_Prod")
		DbCloseArea()
	ENdif
	
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "_prod" , .T., .T.)
	
	dbSelectarea("_prod")
	_cProdutos := Alltrim(_Prod->Produtos)
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis do documento - Dados Cadastrais                     �
	//�������������������������������������������������������������������������
	
	OLE_SetDocumentVar(hWord, "w_nome_Emp"   , aInfo[03] )
	OLE_SetDocumentVar(hWord, "w_CpfCgc_Emp" , aInfo[08] )
	OLE_SetDocumentVar(hWord, "w_NumRda"     , (cAliasTmp)->BAU_CODIGO)
	OLE_SetDocumentVar(hWord, "w_Nome"       , (cAliasTmp)->BAU_NOME  )
	OLE_SetDocumentVar(hWord, "w_CpfCgc"     , (cAliasTmp)->BAU_CPFCGC)
	OLE_SetDocumentVar(hWord, "w_RegCR"      , (cAliasTmp)->BAU_CONREG)
	OLE_SetDocumentVar(hWord, "w_Insc_est"   , (cAliasTmp)->BAU_INSCR ) 
	OLE_SetDocumentVar(hWord, "w_Insc_Mun"   , (cAliasTmp)->BAU_INSCRM)
	OLE_SetDocumentVar(hWord, "w_Sede"       ,  _cSede                )
	OLE_SetDocumentVar(hWord, "w_Cnes"       ,  _cCnes                )
	OLE_SetDocumentVar(hWord, "w_TipoPr"     ,  _cTipoPr              )
	//OLE_SetDocumentVar(hWord, "w_CpfCgc"     ,  _cCPfCgc              )    
	OLE_SetDocumentVar(hWord, "w_Id_Resp"    ,  _cCPfCgc              )
	OLE_SetDocumentVar(hWord, "w_Ident"      ,  _cIdent               )
	OLE_SetDocumentVar(hWord, "w_cRepresenta",  _cRepresenta          )
	OLE_SetDocumentVar(hWord, "w_Praso"      ,  _cPraso               )
	OLE_SetDocumentVar(hWord, "w_DiaPgt"     ,  _cDiaPgt              )
	OLE_SetDocumentVar(hWord, "w_tabHmed"    ,  _cTpTabMed            )
	OLE_SetDocumentVar(hWord, "w_tabHhos"    ,  _cTpTabHos            )
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis do documento - Produtos                             �
	//�������������������������������������������������������������������������
	
	OLE_SetDocumentVar(hWord, "w_produtos"   ,  _cprodutos             )
	
	//�����������������������������������������������������������������������Ŀ
	//� Gerando variaveis do documento - Especialidades                       �
	//�������������������������������������������������������������������������
	
	OLE_SetDocumentVar(hWord, "w_Especialidades" , _cEspec            )
	
	//�����������������������������������������������������������������������Ŀ
	//� Atualizando variaveis do documento                                    �
	//�������������������������������������������������������������������������
	
	OLE_UpdateFields(hWord)
	
	if lImprime
		OLE_PRINTFILE(hWord)
		Sleep(5000)
		OLE_CLOSEFILE(hWord)
	Else
		OLE_SetProperty( hWord, oleWdVisible, .T. )//.T.
		OLE_SetProperty( hWord, oleWdWindowState, "MAX" )
	EndIf
	
	DbSelectArea(cAliasTmp)
	DbSkip()
	
	//If !Eof()
	//	OLE_NewFile( hWord, cPathWrd + cArqDest)
	//EndIf
	
Enddo

If !lImprime
	
	//��������������������������������Ŀ
	//� Fecha Documento Criado no Word �
	//����������������������������������
	OLE_CLOSEFILE(hWord)
Endif
//����������������������������������������Ŀ
//� Encerra link de comunicacao com o word �
//������������������������������������������

OLE_CLOSELINK(hWord)


//����������������������������Ŀ
//� Apaga arquivos tempor�rios �
//������������������������������
DbSelectarea(cAliasTmp)
DbCloseArea()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABW001   �Autor  �Microsiga           � Data �  01/20/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

***********************************
Static Function fBuscEspec(_BauCod)
***********************************

Local _xEspec := " "

cQuery := " SELECT DISTINCT BAQ_CODESP,BAQ_DESCRI FROM "
cQuery += RetSqlName("BAX") + " BAX ,"
cQuery += RetSqlName("BAQ") + " BAQ "
cQuery += " WHERE "
cQuery += " BAX.BAX_CODIGO = '" + _BauCod + "'"

If !Empty(_cEspeAte)
	cQuery += " AND BAX.BAX_CODESP BETWEEN '" + _cEspeDe + "' AND '" + _cEspeAte + "'"
Endif

cQuery += " AND BAX.BAX_CODESP = BAQ.BAQ_CODESP "
cQuery += " AND BAX.D_E_L_E_T_ = ' ' "
cQuery += " AND BAQ.D_E_L_E_T_ = ' ' "

If Select("QRY2") <> 0
	DbSelectArea("QRY2")
	DbCloseArea()
ENdif

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "QRY2" , .T., .T.)

dbSelectarea("QRY2")
DbGoTop()

While !eof()
	_xEspec += Alltrim(QRY2->BAQ_DESCRI) + ","
	QRY2->(DbSkip())
Enddo

Return (Substr(_xEspec,1,Len(_xEspec) -1))
