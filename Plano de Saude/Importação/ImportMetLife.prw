#Include "RWMAKE.CH"
#Include "PROTHEUS.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"

Static cEOL := chr(13) + chr(10)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ImpMetLf   � Autor � Mateus Medeiros    � Data �  13/10/17 ���
�������������������������������������������������������������������������͹��
���Descricao � Importa��o Matricula Odonto. 							  ���
�������������������������������������������������������������������������͹��
���Uso       � Previ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function ImpMetLf()
    
    Local aArea    		:= GetArea()
    Local cDescr		:= ""
    Local cFlag			:= .F.
    
    Private cProg       := "ImpMetLf"
    Private cArqCSV		:= "C:\"
    Private nOpen		:= -1
    Private cDiretorio	:= " "
    Private oDlg		:= Nil
    Private oGet1		:= Nil
    Private oBtn1		:= Nil
    Private oGrp1		:= Nil
    Private oSay1		:= Nil
    Private oSBtn1		:= Nil
    Private oSBtn2		:= Nil
    Private oCombo		:= Nil
    Private nLinhaAtu  	:= 0
    Private cTrbPos
    Private lEnd	    := .F.
    
    cDescr := "Este programa ir� importar as matr�culas para os planos odontol�gicos MetLife de um arquivo CSV."
    
    oDlg              := MSDialog():New( 095,232,301,762,"Importa��o MetLife",,,.F.,,,,,,.T.,,,.T. )
    oGet1             := TGet():New( 062,020,{||cArqCSV},oDlg,206,008,,,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cArqCSV",,)
    oGet1:lReadOnly   := .T.
    
    oButton1          := TBrowseButton():New( 062,228,'...',oDlg,,022,011,,,.F.,.T.,.F.,,.F.,,,)
    
    *-----------------------------------------------------------------------------------------------------------------*
    *Buscar o arquivo no diretorio desejado.                                                                          *
    *Comando para selecionar um arquivo.                                                                              *
    *Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.                                                       *
    *           GETF_LOCALHARD   - Inclui o Harddisk local.                                                           *
    *-----------------------------------------------------------------------------------------------------------------*
    
    oButton1:bAction  := {||cArqCSV := cGetFile("Arquivos CSV (*.CSV)|*.csv|","Selecione o .CSV a importar",1,cDiretorio,.T.,GETF_LOCALHARD)}
    oButton1:cToolTip := "Importar CSV"
    
    oGrp1             := TGroup():New( 008,020,050,252,"",oDlg,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oSay1             := TSay():New( 016,028,{||cDescr},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,226,030)
    oButton2          := tButton():New(082,092,'Avan�ar' ,oDlg,,35,15,,,,.T.)
    oButton2:bAction  := {||If(empty(cArqCSV) .or. right(allTrim(lower(cArqCSV)),4) != ".csv",MsgAlert("Informe um arquivo!"),(cFlag := .T.,oDlg:End()))}
    oButton2:cToolTip := "Ir para o pr�ximo passo"
    
    oButton3          := tButton():New(082,144,'Cancelar',oDlg,,35,15,,,,.T.)
    oButton3:bAction  := {||cFlag := .F.,fClose(nOpen),oDlg:End()}
    oButton3:cToolTip := "Cancela a importa��o"
    
    oDlg:Activate(,,,.T.)
    
    If cFlag == .T.
        Processa({|lEnd|ImportCSV(@lEnd, cArqCSV)},"Aguarde...","",.T.)
    EndIf
    
    RestArea(aArea)
    
Return

//�������������������������������������
//�Efetua a importa��o do arquivo .CSV�
//�������������������������������������

Static Function ImportCSV(lEnd,cArqCSV)
    
    Local cLinha 		:= ""
    Local nTotal		:= 0
    Local _ntot			:= 0
    
    Local cArq    		:= Replace(UPPER(cArqCSV),".CSV","_LOG.TXT")
    Local nHandle 		:= FCreate(cArq)
    Local nCount  		:= 0
    ///Local nOpen 		:= fOpen(cArqCSV,0) // 0 - Leitura; 1 - grava��o; 2 - Leitura e grava��o
    
    Local   aStruc       := {}
    Private	_aDadGrv	:= {}
    Private _nGrvTot	:= 0
    
    
    Private nCodContra  := 0
    Private nCnpjContr  := 0
    Private nEmpresa    := 0
    Private nMatricul   := 0
    Private nTitAssoc   := 0
    Private nCdAssoc    := 0
    Private nCPF        := 0
    Private nDtNasc     := 0
    Private nIdade      := 0
    Private nCateg      := 0
    Private nRelDep     := 0
    Private nRelDep     := 0
    Private nMensal     := 0
    Private nStatus     := 0
    Private nAdesao     := 0
    Private nIniUso     := 0
    Private nCCusto     := 0
    Private nExclusao   := 0
    Private nCNS		:= 0 
    
    
    //���������������������������������������������������������������������Ŀ
    //� Criacao do arquivo temporario...                                    �
    //�����������������������������������������������������������������������
    aAdd(aStruc,{"CAMPO","C",500,0})
    
    //nHdl := fOpen(cArquivo,68)
    cTrbPos := CriaTrab(aStruc,.T.)
    
    If Select("TrbPos") <> 0
        TrbPos->(dbCloseArea())
    End
    
    DbUseArea(.T.,,cTrbPos,"TrbPos",.T.)
    
    lInicio := .T.
    lCabecOk := .T.
    
    // importa arquivo para tabela tempor�ria
    PLSAppTmp(cArqCSV)
    
    TRBPOS->(DbGoTop())
    
    If TRBPOS->(EOF())
        MsgStop("Arquivo Vazio!")
        TRBPOS->(DBCLoseArea())
        Close(oLeTxt)
        lRet := .F.
        Return
    End
    
    nTotal := TRBPOS->(LastRec()-1)
    
    ProcRegua(nTotal)
    
    TRBPOS->(DbGoTop())
    
    While !TRBPOS->(Eof())
        
        If lEnd
            MsgAlert("Interrompido pelo usu�rio","Aviso")
            Return
        EndIf
        
        ++nLinhaAtu
        
        IncProc("Processando a Linha n�mero " + allTrim(Str(nLinhaAtu-1)) + " De " + cValTochar(nTotal))
        
        // Faz a leitura da linha do arquivo e atribui a vari�vel cLinha
        cLinha := UPPER(TRBPOS->CAMPO)
        
        // Se ja passou por todos os registros da planilha CSV sai do while
        if Empty(cLinha) .OR. substring(cLinha,1,1) == ";"
            Exit
        EndIf
        
        // Transfoma todos os ";;" em "; ;", de modo que o StrTokArr ir� retornar sempre
        // um array com o n�mero de colunas correto.
        cLinha := strTran(cLinha,";;","; ;")
        cLinha := strTran(cLinha,";;","; ;")
        
        // Para que o �ltimo item nunca venha vazio.
        cLinha += " ;"
        
        aLinha := strTokArr(cLinha,";")
        
        If lInicio
            lInicio := .F.
            IncProc("Lendo cabe�alho...De: "+cValTochar(nTotal))
            
            if !lLeCabec(aLinha)
                MsgAlert("Cabe�alho inv�lido, favor verificar e reimportar","Aviso")
                Return
            else
                lCabecOk :=  .T.
            endif
            // N�o continua se o cabe�alho n�o estiver Ok
            
        Else
            
            If len(aLinha) > 0 // n�o � linha em branco
                
                *'-------------------------------------------------------------------'*
                *'Fun��o para gravar as informa��es dos Produtos
                *'-------------------------------------------------------------------'*
                fProcDad(aLinha)
                
            EndIf
       
        EndIf
       
        TRBPOS->(dbskip())
        //FT_FSkip()
    EndDo
    
    IncProc("Gravando arquivo de atualiza��es ")
    
    For _ntot := 1 To Len(_aDadGrv)
        
        If nHandle < 0
            
            MsgAlert("Erro durante cria��o do arquivo de atualiza��es.")
            Exit
            
        Else
            
            IncProc("Gravando arquivo de atualiza��es " + cValToChar(_ntot) + " de " + cValTochar(_nGrvTot))
            
            FWrite(nHandle, _aDadGrv[_ntot] + CRLF)
            
        EndIf
        
    Next _ntot
    
    //�������������������������������������������������������������������������������������������������������������������Ŀ
    //�FClose - Comando que fecha o arquivo, liberando o uso para outros programas.                                       �
    //���������������������������������������������������������������������������������������������������������������������
    //FClose(nHandle)
    
    Aviso("ATEN��O","Importa��o finalizada com sucesso!!!",{"Ok"})
    
    //fClose(nOpen)
    
    // Muda a extens�o se tiver importado pelo menos uma linha com sucesso
    //	FT_FUSE() // Fecha o arquivo texto e apaga o mesmo
    
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fProcDad   �Autor  �   � Data �  26/11/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para armazenar os dados lidos do arquivo no vetor   ���
���		     � e gravar na BA1				 							  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function fProcDad(aLinha)
    
    Local _aArea 	:= GetArea()
    Local _aArBA1	:= BA1->(GetArea())
    Local _aArBTS	:= BTS->(GetArea())
    Local _cMatric	:= ""
    Local cAlias1    := getNextAlias()
    Local cProduto  := SupergetMV("MV_XPLAODO", .F., '0131|0133|0134') 
    Local aProd     := {}
    
    aProd := strtokarr(cProduto,'|')
    
    If !(Empty(AllTrim(aLinha[nCPF])))
        
        _cMatric := AllTrim(Replace(aLinha[nCPF], ".",""))
        
        _cMatric := strzero(val(Replace(_cMatric, "-","")),tamsx3("BA1_CPFUSR")[1])
        
		cQuery := "  SELECT  BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO MATRICULA " + cEOL
		cQuery += "FROM "+RetSqlName("BA1")+" BA1, "+RetSqlName("BTS")+" BTS 					  " + cEOL
		cQuery += "WHERE  																		  " + cEOL																	
//	    cQuery += "BA1_CODEMP = '5007'														      " + cEOL
		cQuery += " BA1_CODPLA IN (
			
			/*for nX := 1 to len(aProd)
				
				if nX  > 1 
					cQuery +=  ","
				endif 
									
				cQuery += "'"+ alltrim(aProd[nX]) +"'"  
					
			next  */
		 cQuery += "SELECT BI3_CODIGO FROM "+RetSqlName("BI3")+"  WHERE BI3_CODSEG = '004' AND D_E_L_E_T_ = ' '   " + cEOL	
		cQuery += ") 																			  " + cEOL
	 	cQuery += "AND BA1_DATBLO = ' '															  " + cEOL											
	  	cQuery += "AND   BTS_MATVID = BA1_MATVID                                                  " + cEOL
  		cQuery += "AND BA1_CPFUSR = '"+_cMatric+"'                                                " + cEOL
  		cQuery += "AND BA1_IMAGE = 'ENABLE'                                                       " + cEOL
  		cQuery += "AND BA1.D_E_L_E_T_= ' ' AND BTS.D_E_L_E_T_ = ' '                               " + cEOL

        PlsQuery(cQuery,cAlias1)
        
        if (cAlias1)->(!Eof() )
        	_cMatric := (cAlias1)->MATRICULA
        endif
        
        if select(cAlias1) > 0 
        	dbselectarea(cAlias1)
        	dbclosearea()
        endif 
         
        DbSelectArea("BA1")
        DbSetOrder(2)
        If DbSeek(xFilial("BA1") + _cMatric)
            
          /*  DbSelectArea("BTS")
            DbSetOrder(1)
            If DbSeek(xFilial("BTS") + BA1->BA1_MATVID)
                */
                //----------------------------------------
                //Gravar as altera��es efetuadas
                //----------------------------------------
                aAdd(_aDadGrv,;
                    "Matricula: " + aLinha[nMatricul] + ;
                    " - Matricula Odonto: " + AllTrim(aLinha[nCdAssoc]) )
                
                RecLock("BA1", .F.)
                
//                BA1->BA1_YSTODO := AllTrim(aLinha[nCdAssoc])
                BA1->BA1_YMTODO := AllTrim(aLinha[nCdAssoc])
                
                BA1->(MsUnLock())
                
                _nGrvTot ++
                
            //EndIf
            
        Else
            
            //----------------------------------------
            //Gravar os registros n�o encontrados
            //----------------------------------------
            aAdd(_aDadGrv,;
                "Matricula: " + aLinha[nMatricul] + ;
                " - Nao encontrado no sistema. " )
            
            _nGrvTot ++
            
        EndIf
        
    EndIf
    
    RestArea(_aArBA1)
    RestArea(_aArea)
    
Return

// Append arquivo em tabela temporaria
Static Function PLSAppTmp(cNomeArq)
    
    DbSelectArea("TRBPOS")
    Append From &(cNomeArq) SDF
    
Return

// Valida Cabe�alho
Static Function lLeCabec(aLinha)
    
    Local lRet := .T.
    
    nCodContra := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CODIGO_CONTRATO"   })
    nCnpjContr := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CNPJ_CONTRATO"     })
    nEmpresa   := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "NM_EMPRESA"        })
    nMatricul  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "MATRICULA"         })
    nTitAssoc  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "TITULAR"           })
    nAssoc     := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "ASSOCIADO"         })
    nCdAssoc   := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CD_ASSOCIADO"      })
    nCPF       := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CD_CPF"            })
    nDtNasc    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DT_NASCIMENTO"     })
    nIdade     := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "IDADE"             })
    nCateg     := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CATEGORIA"         })
    nRelDep    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "REL_DEPENDENCIA"   })
    nPlano     := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "PLANO"             })
    nMensal    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "VALOR_MENSALIDADE" })
    nStatus    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "STATUS"            })
    nAdesao    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DATA_ADESAO"       })
    nIniUso    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "SUB_EMPRESA"       })
    nCCusto    := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CENTRO_CUSTO"      })
    nExclusao  := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "DT_EXCLUSAO"       })
    nCNS  	   := aScan(aLinha,{|x| Alltrim(UPPER(x)) == "CNS"       		 })  
      
      
    if nCodContra       == 0
        lRet := .F.
    elseif nCnpjContr   == 0
        lRet := .F.
    elseif nEmpresa     == 0
        lRet := .F.
    elseif nMatricul   == 0
        lRet := .F.
    elseif nTitAssoc    == 0
        lRet := .F.
    elseif nCdAssoc     == 0
        lRet := .F.
    elseif nCPF         == 0
        lRet := .F.
    elseif nDtNasc      == 0
        lRet := .F.
    elseif nIdade       == 0
        lRet := .F.
    elseif nCateg       == 0
        lRet := .F.
    elseif nRelDep      == 0
        lRet := .F.
    elseif nPlano       == 0
        lRet := .F.
    elseif nMensal      == 0
        lRet := .F.
    elseif nStatus      == 0
        lRet := .F.
    elseif nAdesao      == 0
        lRet := .F.
    elseif nIniUso      == 0
        lRet := .F.
    elseif nCCusto      == 0
        lRet := .F.
    elseif nExclusao    == 0
        lRet := .F.
    endif
    
Return lRet