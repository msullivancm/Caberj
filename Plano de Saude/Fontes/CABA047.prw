#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'   
#INCLUDE 'UTILIDADES.CH'

#DEFINE c_ent CHR(13) + CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA047 �Autor    �XXXXX               | Data �  08/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Programa para realizar o update nas guias especificadas    ���
���          � de acordo com o RDA e compet�ncia, movendo as mesmas da    ���
���          � filial '  ' para  a filial '13' e realizando o retorno     ���   
���          � dessas guias quando necess�rio.                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABA047

Local   i          := 0
Local   aGuiTExcel := {}
Local   aGuiFExcel := {}

Private cQuery     := ""
Private cPerg      := "CABA47"
Private cTransf    := ""
Private cTipoGuia  := ""
Private aGuias     := {}  
Private lExecuta   := .T. 
Private cFilOri    := "" //filial original e para onde ser�o retornadas
Private cFilTrans  := "13" //Filial para onde as guias ser�o transferidas
Private cFilDest   := "" //Filial de destino do processamento 
Private cCodRDA    := ""
Private cCompet    := ""  
Private cCodOpe    := PLSINTPAD()
Private lProbBD5   := .F.
Private lProbBD6   := .F.
Private lProbBD7   := .F.
Private nValTot    := 0  
Private aGuiasFat  := {} //vetor que cont�m as guias que j� foram faturadas e, por isso, n�o puderam ser transferidas
Private aGuiasTran := {} //vetor que contem as guias que foram transferidas com sucesso.       

CriaSX1() 

If !Pergunte(cPerg,.T.)
	Return
EndIf


If !APMSGYESNO("Deseja executar a transfer�ncia de filial para os par�metros especificados?")
	
//Else
	Return
EndIf

If MV_PAR04 = 1
	cTransf  := "Transfere"
	cFilOri  := "  "
	cFilDest := cFilTrans
Else
	cTransf  := "Retorna"
	cFilOri  := cFilTrans
	cFilDest := "  "
EndIf

If MV_PAR05 = 1
	cTipoGuia := "Bloq" //bloqueadas
Else
	cTipoGuia := "Ativa"//em ativa pronta
EndIf

cCodRDA := MV_PAR03		                                                                                                                                                                                                                                                                                                            
cCompet := MV_PAR02+MV_PAR01

Processa({|| TRANSFIL()  },"Processando transfer�ncia/retorno de filial ctas m�dicas...")


If !lExecuta //termina a execu��o caso n�o exista registro a ser processado...
	APMSGINFO("Aten��o, n�o existem registros a serem processados com os par�metros informados.")
	Return
EndIf
If Len(aGuiasFat)>0
	APMSGINFO("Aten��o! Dentre as guias que voc� tentou transferir existem guias faturadas ou parcialmente faturadas e, por motivo de consist�ncia de base, n�o puderam ser movidas para outra filial. Ser� exibido agora um relat�rio com essas guias que n�o puderam ser movidas.","Relat�rio de guias Faturadas.")
	RelGuiaFat()
	If APMSGYESNO("Deseja gerar um relat�rio em excel com as guias que nao foram movidas de filial?","Gerar listagem em Excel?")
		aAdd( aGuiFExcel, {"Operadora","Local de Digita��o","PEG","Guia","Valor","Grupo Plano","Plano","Compet�ncia","C�d. RDA","Nome do RDA","Matricula","Tipo Registro","D�gito","Nome" } )
		//aAdd( aGuiasFat, {cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4],aGuias[i][6],aGuias[i][7],aGuias[i][8],aGuias[i][9],aGuias[i][10],aGuias[i][11],aGuias[i][12],aGuias[i][13],aGuias[i][14],aGuias[i][15]} )
		For i := 1 To Len(aGuiasFat)
			aAdd( aGuiFExcel, {SubStr(aGuiasFat[i][1],1,4),SubStr(aGuiasFat[i][1],5,4),SubStr(aGuiasFat[i][1],9,8),SubStr(aGuiasFat[i][1],17,8),aGuiasFat[i][2],aGuiasFat[i][3],;
			aGuiasFat[i][4],aGuiasFat[i][5],aGuiasFat[i][6],aGuiasFat[i][7],aGuiasFat[i][8],aGuiasFat[i][9],aGuiasFat[i][10],aGuiasFat[i][11] } )
		Next i
		DlgToExcel({{"ARRAY","Guias que n�o foram movidas","",aGuiFExcel}})
	EndIf 
EndIf


If Len(aGuiasTran)>0
	RelGuiTran()
	If APMSGYESNO("Deseja emitir um relat�rio em excel com as guias que foram transferidas/retornadas com sucesso?","Gerar listagem das transfer�ncias/retornos?")
		aAdd(aGuiTExcel, {"Filial Destino","Operadora","Local Digita��o","PEG","Guia","Valor","Plano","C�d. RDA","Nome RDA","Transfer�ncia/Retorno","Data Movimenta��o","Compet�ncia","C�d. Usuario Respons�vel","Nome Usu�rio"} )
		For i := 1 to Len(aGuiasTran)
			aAdd(aGuiTExcel, {aGuiasTran[i][1],SubStr(aGuiasTran[i][2],1,4),SubStr(aGuiasTran[i][2],5,4),SubStr(aGuiasTran[i][2],9,8),SubStr(aGuiasTran[i][2],17,8),;
			aGuiasTran[i][3],aGuiasTran[i][4],aGuiasTran[i][5],aGuiasTran[i][6],aGuiasTran[i][7],aGuiasTran[i][8],aGuiasTran[i][9],aGuiasTran[i][10],aGuiasTran[i][11]} )				
		Next i
		DlgToExcel({{"ARRAY","Guias que foram movidas","",aGuiTExcel}})
	EndIf
EndIf

APMSGINFO("Processo finalizado com sucesso.")

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TRANSFIL   �Autor  �Renato Peixoto     � Data �  08/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina respons�vel por transferir/retornar filial.         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function TRANSFIL()

Local cArqQry   := GetNextAlias()
Local i,j       := 0  
Local nContReg  := 0
Local cQuery2   := ""
Local cQuery3   := ""
Local cQuery4   := ""
Local cArqQry2  := GetNextAlias() 
Local lFaturada := .F.
Local nPos      := 0
Local cSequen   := ""


//If cTransf = "Transfere"
//Guias com bloqueio de pagamento
If cTipoGuia = "Bloq"
	

	cQuery := "  SELECT  " // /*+first_rows index_asc(BD7 BD70105)*/ "+c_ent
	cQuery += "  BD7_FILIAL, bd7_codldp, bd7_codpeg, bd7_numero, BD7_CODPLA PLANO, "+c_ent
	cQuery += "  Sum(BD7F.VLRPAG)  Vl_Aprov,  "+c_ent
    cQuery += "	 DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "+c_ent
    cQuery += "  Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, "+c_ent
	cQuery += "  ZZT_TPCUST , "+c_ent
	cQuery += "    BD6_ANOPAG||BD6_MESPAG REFGUIA, "+c_ent
    //cQuery += "    TO_DATE(BD6_ANOPAG||BD6_MESPAG||'01','YYYYMMDD') REFGUIA, "+c_ent
    //cQuery += "       		 ' ' gRUPO, "+c_ent
    cQuery += "       		 BD7_CODRDA, RDA, bd6_matric, bd6_tipreg, bd6_digito, bd6_nomusr "+c_ent
    //cQuery += "   		     'Conta' Tipo

  	cQuery += "  			FROM "+c_ent
   	cQuery += "  				(SELECT BD7.BD7_FILIAL,BD7_CODPLA, "+c_ent
    cQuery += "  			    BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "+c_ent
    cQuery += "        			BD7_CODRDA,TRIM(BD7_NOMRDA) RDA, "+c_ent
    cQuery += "       			BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, "+c_ent
    cQuery += "        			BD7.BD7_SEQUEN, BD6.BD6_QTDPRO, Sum(BD7.BD7_VLRPAG) AS VLRPAG, "+c_ent
    cQuery += "       			COUNT(DISTINCT BD7_CODEMP||BD7_MATRIC||BD7_TIPREG) QTDE "+c_ent
   	cQuery += "  				FROM "+RetSqlName("BD7")+" BD7, "+RetSqlName("BAU")+" BAU, "+RetSqlName("BD6")+" BD6 "+c_ent
   	cQuery += "  				WHERE BD7.BD7_FILIAL='"+cFilOri+"'      AND  "+c_ent
   	cQuery += "  				BAU_FILIAL = '"+IIF(cTransf="Transfere",cFilOri,"  ")+"' "+c_ent
   	cQuery += "  				AND BD6.BD6_FILIAL = '"+cFilOri+"' "+c_ent
   	cQuery += "  				AND BD7_CODOPE = '0001' "+c_ent
  	cQuery += "  				AND BD7_ANOPAG||BD7_MESPAG = '"+cCompet+"' "+c_ent//FILTRO PARA COMPETENCIA DE PAGAMENTO 
   	cQuery += "  				AND BD7_SITUAC = '1' "+c_ent
    cQuery += "  				and BD7_FASE ='3' "+c_ent//SOMENTE PRONTAS PARA PAGAMENTO
   	cQuery += "  				and BD7_LOTBLO <> ' ' "+c_ent
   	cQuery += "  				AND BD7_BLOPAG='1' "+c_ent
   	cQuery += "  				AND BD7.bd7_VLRPAG <> 0 "+c_ent
   	cQuery += "  				AND BD7_CODLDP<>'0013' "+c_ent
   	cQuery += "  				AND BD7_CONPAG<>'0' "+c_ent
   	cQuery += "  				and bd7_codrda = '"+cCodRDA+"' "+c_ent
   	cQuery += "  				AND BAU.BAU_CODIGO = BD6_CODRDA "+c_ent
   	cQuery += "  				AND BD6.BD6_CODOPE = BD7.BD7_CODOPE "+c_ent
   	cQuery += "  				AND BD6.BD6_CODLDP = BD7.BD7_CODLDP "+c_ent
   	cQuery += "  				AND BD6.BD6_CODPEG = BD7.BD7_CODPEG "+c_ent
   	cQuery += "  				AND BD6.BD6_NUMERO = BD7.BD7_NUMERO "+c_ent
   	cQuery += "  				AND BD6.BD6_ORIMOV = BD7.BD7_ORIMOV "+c_ent
   	cQuery += "  				AND BD6.BD6_SEQUEN = BD7.BD7_SEQUEN "+c_ent
   	cQuery += "  				AND BD6.BD6_CODPRO = BD7.BD7_CODPRO "+c_ent

   	cQuery += "  				AND BD6.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  				AND BD7.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  				AND BAU.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  				GROUP BY BD7_FILIAL, BD7_CODPLA, BD7.BD7_OPELOT,BD7.BD7_NUMLOT,BD7_CODPRO,
    cQuery += "         			BD7_CODRDA,TRIM(BD7_NOMRDA),
    cQuery += "         			BD7_FILIAL, BD7_CODOPE, BD7_CODLDP, BD7_CODPEG, BD7_NUMERO, BD7_ORIMOV, BD7_SEQUEN, BD6.BD6_QTDPRO) BD7F,
   	cQuery += "  				"+RetSqlName("BD6")+" BD6F ,"+RetSqlName("BI3")+" BI3 ,"+RetSqlName("ZZT")+" ZZT ,"+RetSqlName("BG9")+" BG9 "+c_ent

  	cQuery += "  			WHERE ZZT_FILIAL='"+IIF(cTransf="Transfere",cFilOri,"  ")+"' "+c_ent
   	cQuery += "  			AND BI3_FILIAL='"+IIF(cTransf="Transfere",cFilOri,"  ")+"' "+c_ent
   	cQuery += "  			AND BG9_FILIAL='"+IIF(cTransf="Transfere",cFilOri,"  ")+"' "+c_ent
   	cQuery += "  			AND BD6F.BD6_FILIAL='"+cFilOri+"' "+c_ent
   	cQuery += "  			AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "+c_ent
  	cQuery += "  			AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "+c_ent
   	cQuery += "  			AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "+c_ent
   	cQuery += "  			AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "+c_ent
   	cQuery += "  			AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "+c_ent
  	cQuery += "  			AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "+c_ent
   	cQuery += "  			AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "+c_ent
   	cQuery += "  			AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "+c_ent
    cQuery += "  
  	If cTransf = "Transfere"
  		cQuery += "  			AND BI3_FILIAL =BD7_FILIAL "+c_ent
   	EndIf
   	cQuery += "  			AND BI3_CODINT=BD7_CODOPE  "+c_ent
   	cQuery += "  			AND BI3_CODIGO=BD7_CODPLA "+c_ent
   	cQuery += "  			AND BD6_OPEUSR=BG9_CODINT "+c_ent
   	cQuery += "  			AND BD6_CODEMP=BG9_CODIGO "+c_ent
    
    //Inicio - Alteracao na funcao Oracle RETORNA_EVENTO_BD5. O parametro pVIDA nao eh usado dentro da funcao, logo foi compilado sem ele na producao. Estou alterando 
    //aqui pois antes a informacao era passada mas nunca foi utilizada.
   	
    //atencao com essa funcao abaixo se vai dar problema no retorno da filial
   	//cQuery += "  			AND RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'C' )=ZZT_CODEV "+c_ent
   	cQuery += "  			AND RETORNA_EVENTO_BD5 (BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,'C' )=ZZT_CODEV "+c_ent
    
	//Fim
	
    cQuery += "  			AND BD6F.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  			AND BI3.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  			AND ZZT.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "  			AND BG9.D_E_L_E_T_ = ' ' "+c_ent
  	cQuery += "  			GROUP BY BD7_FILIAL, "+c_ent
 	cQuery += "             BD6_CODEMP, "+c_ent
    cQuery += "       		BG9_DESCRI, "+c_ent
    cQuery += "       		bd7_codldp, bd7_codpeg, bd7_numero, "+c_ent
    cQuery += "       		BD7_CODPLA, "+c_ent
    cQuery += "       		TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "+c_ent
    cQuery += "       		BD7_CODRDA,RDA, "+c_ent
    cQuery += "       		ZZT_TPCUST, "+c_ent
    cQuery += "             BD6_ANOPAG||BD6_MESPAG, bd6_matric, bd6_tipreg, bd6_digito, bd6_nomusr "+c_ent
    //cQuery += "       		TO_DATE(BD6_ANOPAG||BD6_MESPAG||'01','YYYYMMDD') "+c_ent
             

Else
             
	//Guias em Ativa Pronta
  	cQuery := "SELECT   " ///*+first_rows index_asc(BD7 BD70105)*/ "+c_ent 
    cQuery += "BD7_FILIAL, bd7_codldp, bd7_codpeg, bd7_numero, "+c_ent
    cQuery += "     BD7_CODPLA PLANO, "+c_ent
    cQuery += "     Sum(BD7F.VLRPAG)  Vl_Aprov, "+c_ent
    //cQuery += "    -- sum(Decode(BD6F.BD6_BLOCPA,'1',0,Decode(Sign(BD6F.BD6_VLRTPF),-1,0,Decode(BD6_CODEMP,'0004',0,'0009',0,BD6F.BD6_VLRTPF)))) "Vl_Participacao",
    cQuery += "     DECODE(TRIM(BI3_YGRPLA),'4','MATER','2','AFINIDADE','3','EMPRESARIAL','1','ADMINISTRATIVO') GRUPO_PLANO, "+c_ent
    cQuery += "     Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ) NOME_PLANO, "+c_ent
    cQuery += "    BD6_ANOPAG||BD6_MESPAG REFGUIA, "+c_ent
    //cQuery += "    TO_DATE(BD6_ANOPAG||BD6_MESPAG||'01','YYYYMMDD') REFGUIA, "+c_ent
    //cQuery += "     ' ' gRUPO, "+c_ent
    cQuery += "     BD7_CODRDA, RDA, bd6_matric, bd6_tipreg, bd6_digito, bd6_nomusr "+c_ent
    //cQuery += "     'Conta' Tipo


  	cQuery += "FROM "+c_ent
  	cQuery += "	    (SELECT BD7.BD7_FILIAL,BD7_CODPLA, "+c_ent
    cQuery += "	    BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "+c_ent
    cQuery += "     BD7_CODRDA,TRIM(BD7_NOMRDA) RDA, "+c_ent
    cQuery += "     BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, "+c_ent
    cQuery += "     BD7.BD7_SEQUEN, Sum(BD7.BD7_VLRPAG) AS VLRPAG "+c_ent
   	cQuery += " 	FROM "+RetSqlName("BD7")+" BD7, "+RetSqlName("BAU")+" BAU "+c_ent
   	cQuery += "		where BD7.BD7_FILIAL='"+cFilOri+"' "+c_ent
   	cQuery += "		AND trim(BAU_FILIAL) is null "+c_ent
   	cQuery += "		AND BD7_CODOPE = '0001' "+c_ent
   	cQuery += "		AND BD7_ANOPAG||BD7_MESPAG = '"+cCompet+"' "+c_ent //--FILTRO PARA COMPETENCIA DE PAGAMENTO
   	cQuery += "		AND BD7_SITUAC = '1' "+c_ent
   	cQuery += "		AND BD7_FASE ='3' "+c_ent //--SOMENTE PRONTAS PARA PAGAMENTO
   	cQuery += "		and BD7_BLOPAG <> '1' "+c_ent
   	cQuery += "		AND BD7_LOTBLO=' ' "+c_ent
   	cQuery += "		and BD7.BD7_VLRPAG <> 0 "+c_ent
   	cQuery += "		AND BD7_CONPAG<>'0' "+c_ent
   	cQuery += "		and BD7_CODLDP<>'0013' "+c_ent
   	cQuery += "		and bd7_codrda = '"+cCodRDA+"'
   	cQuery += "		and BAU.BAU_CODIGO(+) = BD7_CODRDA "+c_ent
   	cQuery += "		AND BD7.D_E_L_E_T_ = ' ' "+c_ent
  	cQuery += "		AND trim(BAU.D_E_L_E_T_ ) is null "+c_ent
 	cQuery += "		group by BD7.BD7_FILIAL,BD7_CODPLA, "+c_ent
    cQuery += "		BD7.BD7_OPELOT,BD7.BD7_NUMLOT, "+c_ent
    cQuery += "		BD7_CODRDA,TRIM(BD7_NOMRDA) , "+c_ent
    cQuery += "		BD7.BD7_CODOPE, BD7.BD7_CODLDP, BD7.BD7_CODPEG, BD7.BD7_NUMERO, BD7.BD7_ORIMOV, BD7_CODPRO, "+c_ent
    cQuery += " 	BD7.BD7_SEQUEN  "+c_ent 
  	cQuery += ") BD7F, "+c_ent
   	cQuery += " "+RetSqlName("BD6")+" BD6F , "+RetSqlName("BI3")+" BI3  "+c_ent

  	cQuery += "WHERE  BI3_FILIAL='"+IIF(cTransf="Transfere",cFilOri,"  ")+"' "+c_ent
   	cQuery += "AND BD6F.BD6_FILIAL='"+cFilOri+"' "+c_ent
   	cQuery += "AND BD7F.BD7_FILIAL = BD6F.BD6_FILIAL "+c_ent
   	cQuery += "AND BD7F.BD7_CODOPE = BD6F.BD6_CODOPE "+c_ent
 	cQuery += "AND BD7F.BD7_CODLDP = BD6F.BD6_CODLDP "+c_ent
   	cQuery += "AND BD7F.BD7_CODPEG = BD6F.BD6_CODPEG "+c_ent
   	cQuery += "AND BD7F.BD7_NUMERO = BD6F.BD6_NUMERO "+c_ent
   	cQuery += "AND BD7F.BD7_ORIMOV = BD6F.BD6_ORIMOV "+c_ent
   	cQuery += "AND BD7F.BD7_SEQUEN = BD6F.BD6_SEQUEN "+c_ent
   	cQuery += "AND BD6F.BD6_CODPRO = BD7F.BD7_CODPRO "+c_ent
   	If cTransf = "Transfere" 
   		cQuery += "AND BI3_FILIAL =BD7_FILIAL "+c_ent
   	EndIf
   	cQuery += "AND BI3_CODINT=BD7_CODOPE "+c_ent
   	cQuery += "AND BI3_CODIGO=BD7_CODPLA "+c_ent

   	cQuery += "AND BD6F.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "AND BI3.D_E_L_E_T_ = ' ' "+c_ent
   	cQuery += "GROUP BY BD7_FILIAL, BD6_CODEMP, "+c_ent
    cQuery += "bd7_codldp, bd7_codpeg, bd7_numero, "+c_ent
    cQuery += "BD7_CODPLA, "+c_ent
    cQuery += "TRIM(BI3_YGRPLA),Decode(BD6_CODEMP,'0007',Trim(BI3_NREDUZ)||' (SEPE)',BI3_NREDUZ), "+c_ent
	cQuery += "BD7_CODRDA,RDA, "+c_ent
	cQuery += "BD6_ANOPAG||BD6_MESPAG, bd6_matric, bd6_tipreg, bd6_digito, bd6_nomusr  "+c_ent
    //cQuery += "TO_DATE(BD6_ANOPAG||BD6_MESPAG||'01','YYYYMMDD')  "+c_ent
    
EndIf
     

If Select(cArqQry)>0
	(cArqQry)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

If (cArqQry)->(Eof())
	APMSGSTOP("Aten��o, n�o existem dados a serem processados com os par�metros informados.")
	lExecuta := .F.
	Return 
EndIf

While !((cArqQry)->(Eof()))
	
	aAdd(aGuias, { (cArqQry)->BD7_FILIAL, (cArqQry)->BD7_CODLDP, (cArqQry)->BD7_CODPEG, (cArqQry)->BD7_NUMERO, (cArqQry)->PLANO, (cArqQry)->VL_APROV,;
	(cArqQry)->GRUPO_PLANO, (cArqQry)->NOME_PLANO, (cArqQry)->REFGUIA, (cArqQry)->BD7_CODRDA, (cArqQry)->RDA, (cArqQry)->bd6_matric, (cArqQry)->bd6_tipreg, (cArqQry)->bd6_digito, (cArqQry)->bd6_nomusr } )
	
    (cArqQry)->(DbSkip())
    
EndDo

For j := 1 To Len(aGuias)
	nValTot += aGuias[j][6]
Next j

If !(APMSGYESNO("O total trazido de acordo com os par�metros informados � de R$ "+AllTrim(STR(nValTot))+". Deseja Continuar?","Verifique o valor!"))
	Return
EndIf

nContReg := Len(aGuias)
ProcRegua(nContReg)

//Processa as transfer�ncias/retorno  cFilDest := cFilTrans
For i := 1 To Len(aGuias)
    lProbBD5 := .F.
    lProbBD6 := .F.
    lProbBD7 := .F.
	lFaturada := .F.
	
	If aScan( aGuiasTran, { |x| x[2] = cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4] } ) > 0 //se j� encontrar a chave da guia no vetor, significa que o processo de transferencia/retorno de filial ja foi realizado para a guia em questao
		//se entrar aqui tem que atualizar o registro da PAY, somando o valor dessa guia que vou pular e tb atualizar o vetor que contem essa guia que foi transferida (aGuiasTran)
		nPos := aScan( aGuiasTran, { |x| x[2] = cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4] } )
		aGuiasTran[nPos][3] += aGuias[i][6]
		cSequen := SeqPAY(cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		DbSelectArea("PAY")
		DbSetOrder(1)
		If DbSeek(cFilDest+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+STRZERO(Val(cSequen)-1,2) )
			RecLock("PAY",.F.)
			PAY->PAY_VLAPRO += aGuias[i][6]
			PAY->(MsUnlock())
		EndIf 
		Loop
	EndIf
	//verifica na BE4 ou BD5 se a guia est� faturada (fase 4)
	If aGuias[i][2] = '0000' .OR. aGuias[i][2] = '0003' .OR. aGuias[i][2] == "0016"
		TRY
			DbSelectArea("BE4")
			DbSetOrder(1) 
	    	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
	    		If BE4->BE4_FASE = "4"
	    			lFaturada := .T.
	    		EndIf
		    EndIf
		
		CATCH
			DbSelectArea("BD5")
			DbSetOrder(1)
			If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
				If BD5->BD5_FASE = "4"
					lFaturada := .T.
				EndIf
			EndIf
		ENDCATCH
	Else
		DbSelectArea("BD5")
		DbSetOrder(1)
		If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
			If BD5->BD5_FASE = "4"
				lFaturada := .T.
			EndIf
		EndIf	  
	EndIf	
	
	//Acrescentado por Renato Peixoto em 23/07/12
	//Se j� encontrar BD5 ou BE4 em fase 4, ja paro a transferencia logo nesse ponto...
	If lFaturada
		aAdd( aGuiasFat, {cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4],aGuias[i][6],aGuias[i][7],aGuias[i][8],aGuias[i][9],aGuias[i][10],aGuias[i][11],aGuias[i][12],aGuias[i][13],aGuias[i][14],aGuias[i][15]} )
		Loop
	EndIf
	
	//Verifico na BD6 se existe algum item faturado
	DbSelectArea("BD6")
	DbSetOrder(1)
	BD6->(DbGoTop())
	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		While !(BD6->(Eof())) .AND. BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO = cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]
			If BD6->BD6_FASE = "4" .AND. BD6->BD6_VLRPAG > 0 //se estiver faturada mas com o valor zerado, pode mover para outra filial. Renato Peixoto em 23/07/12
				lFaturada := .T.
				Exit
			EndIf
			BD6->(DbSkip())
		EndDo
	EndIf
	
	If lFaturada
		//desenvolver logica para exibir em um relat�rio as guias que nao puderam ser transferidas por estarem parcialmente faturadas
		aAdd( aGuiasFat, {cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4],aGuias[i][6],aGuias[i][7],aGuias[i][8],aGuias[i][9],aGuias[i][10],aGuias[i][11],aGuias[i][12],aGuias[i][13],aGuias[i][14],aGuias[i][15]} )
		Loop
	EndIf
			
	
	//Verifico na BD7 se existe algum item faturado
	DbSelectArea("BD7")
	DbSetOrder(1)
	BD7->(DbGoTop())
	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		While !(BD7->(Eof())) .AND. BD7->BD7_CODOPE+BD7->BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO = cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]
			If BD7->BD7_FASE = "4" .AND. BD7->BD7_VLRPAG > 0 //se estiver faturada mas com o valor zerado, pode mover para outra filial. Renato Peixoto em 23/07/12
				lFaturada := .T.
				Exit
			EndIf
			BD7->(DbSkip())
		EndDo
	EndIf
	
	If lFaturada
		//desenvolver logica para exibir em um relat�rio as guias que nao puderam ser transferidas por estarem parcialmente faturadas
		aAdd( aGuiasFat, {cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4],aGuias[i][6],aGuias[i][7],aGuias[i][8],aGuias[i][9],aGuias[i][10],aGuias[i][11],aGuias[i][12],aGuias[i][13],aGuias[i][14],aGuias[i][15]} )
		Loop
	EndIf
	
	IncProc("Realizando Transfer�ncia/Retorno de filial. Por favor aguarde...")
	//If cTransf  := "Transfere"
	
	If aGuias[i][2] = '0000' .OR. aGuias[i][2] = '0003' .OR. aGuias[i][2] = "0016"
	
		TRY
			DbSelectArea("BE4")
			DbSetOrder(1) 
	    	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
	    		RecLock("BE4",.F.)
	    		BE4->BE4_FILIAL := cFilDest
	    		BE4->(MsUnlock())
		    EndIf
		
		CATCH
		
			DbSelectArea("BD5")
			DbSetOrder(1)
			If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
				RecLock("BD5",.F.)
				BD5->BD5_FILIAL := cFilDest
				BD5->(MsUnlock())
			EndIf
		
		ENDCATCH
	    
	Else
	   
	   	DbSelectArea("BD5")
		DbSetOrder(1)
		If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
			RecLock("BD5",.F.)
			BD5->BD5_FILIAL := cFilDest
			BD5->(MsUnlock())
		Else
			lProbBD5 := .T.
			APMSGINFO("Aten��o, houve um problema na transfer�ncia de uma guia das guias selecionadas (BD5). Chave da guia: "+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+". " )
		EndIf
		
	EndIf  
		
	//Transfere na BD6
	DbSelectArea("BD6")
	DbSetOrder(1)
	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		/*While !(BD6->(Eof())) .AND. (cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4] = BD6->BD6_CODOPE+BD6->BD6_CODLDP+BD6->BD6_CODPEG+BD6->BD6_NUMERO)
			RecLock("BD6",.F.)
			BD6->BD6_FILIAL := cFilDest
			BD6->(MsUnlock())
			BD6->(DbSKip())
		EndDo*/
		If cTipoGuia = "Bloq"  //bloqueadas
			                  
			cQuery2 := "UPDATE "+RetSqlName("BD6")+" SET BD6_FILIAL = '"+cFilDest+"' "
			cQuery2 += "WHERE BD6_FILIAL = '"+cFilOri+"' "
			cQuery2 += "AND BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO = '"+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+"' "
			cQuery2 += "AND BD6_SITUAC = '1' "
        	cQuery2 += "AND ( (BD6_FASE ='3') OR ( BD6_FASE = '4' AND BD6_VLRPAG = 0 ) ) " //Acrescentado tratamento de valor zerado quando a fase for 4. Renato Peixoto em 24/07/12
       		//cQuery2 += "AND BD6_BLOPAG='1' " //comentado em 07/11/2011 por Renato Peixoto, pois na BD6 nao fica bloqueado, apenas na BD7
      		//cQuery2 += "AND BD6_VLRPAG <> 0 " //Comentado em 24/07/12 e passei a tratar valor zerado apenas se a fase for 4
      		cQuery2 += "AND D_E_L_E_T_ = ' ' " 
      		TCSqlExec(cQuery2)
      		
   		Else //ativas pronta
   			
   			cQuery2 := "UPDATE "+RetSqlName("BD6")+" SET BD6_FILIAL = '"+cFilDest+"' "
			cQuery2 += "WHERE BD6_FILIAL = '"+cFilOri+"' "
			cQuery2 += "AND BD6_CODOPE||BD6_CODLDP||BD6_CODPEG||BD6_NUMERO = '"+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+"' "
			cQuery2 += "AND BD6_SITUAC = '1' "
      		//cQuery2 += "AND BD6_FASE ='3' " //comentado em 24/07/12 para tratar fase 4 com valor = 0. Renato Peixoto.
      		cQuery2 += "AND ( (BD6_FASE ='3') OR ( BD6_FASE = '4' AND BD6_VLRPAG = 0 ) ) " //Acrescentado tratamento de valor zerado quando a fase for 4. Renato Peixoto em 24/07/12
      		cQuery2 += "AND BD6_BLOPAG <> '1' "+c_ent
      		//cQuery2 += "AND BD6_VLRPAG <> 0 " comentado em 24/07/12. Posso transferir na fase 3 independente se o valor esta zerado ou nao. Renato Peixoto.
      		cQuery2 += "AND D_E_L_E_T_ = ' ' "	
      		TCSqlExec(cQuery2)
      		
   		EndIf
      	
	Else
		lProbBD6 := .T.
		APMSGINFO("Aten��o, houve um problema na transfer�ncia de uma guia das guias selecionadas (BD6). Chave da guia: "+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+". " )
	EndIf
		
	//Transfere filial na BD7
	DbSelectArea("BD7")
	DbSetOrder(2)
	If DbSeek(cFilOri+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		/*While !(BD7->(Eof())) .AND. (cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4] = BD7->BD7_CODOPE+BD7->BD7_CODLDP+BD7->BD7_CODPEG+BD7->BD7_NUMERO)
			RecLock("BD7",.F.)
			BD7->BD7_FILIAL := cFilDest
			BD7->(MsUnlock())
			BD7->(DbSKip())
		EndDo*/
		If cTipoGuia = "Bloq"  //bloqueadas
			cQuery3 := "UPDATE "+RetSqlName("BD7")+" SET BD7_FILIAL = '"+cFilDest+"' "
			cQuery3 += "WHERE BD7_FILIAL = '"+cFilOri+"' "
			cQuery3 += "AND BD7_CODOPE||BD7_CODLDP||BD7_CODPEG||BD7_NUMERO = '"+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+"' "
			cQuery3 += "AND BD7_SITUAC = '1' "                                	
        	//cQuery3 += "AND BD7_FASE ='3' " //Comentado por Renato Peixoto em  24/07/12 para tratar tambem bd7 com fase 4, mas com valor zerado.
       		cQuery3 += "AND ( (BD7_FASE = '3') OR (bd7_fase = '4' AND bd7_vlrpag = 0 ) ) " //Adicionado em 24/07/12 por Renato Peixoto para tratar bd7 com fase 4 mas com valor zerado
       		cQuery3 += "AND BD7_BLOPAG='1' "
       		cQuery3 += "AND BD7_LOTBLO <> ' ' "
      		//cQuery3 += "AND BD7_VLRPAG <> 0 "   //se estiver com valor zerado pode trazer tambem para transferir filial. Renato Peixoto em 23/07/12
      		cQuery3 += "AND D_E_L_E_T_ = ' ' " 
      		TCSqlExec(cQuery3)
		Else//ativas pronta
   			
   			cQuery3 := "UPDATE "+RetSqlName("BD7")+" SET BD7_FILIAL = '"+cFilDest+"' "
			cQuery3 += "WHERE BD7_FILIAL = '"+cFilOri+"' "
			cQuery3 += "AND BD7_CODOPE||BD7_CODLDP||BD7_CODPEG||BD7_NUMERO = '"+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+"' "
			cQuery3 += "AND BD7_SITUAC = '1' "
      		//cQuery3 += "AND BD7_FASE ='3' " //COmentado por Renato Peixoto em 24/07/12 para tratar bd7 com fase 4, mas com valor zerado.
      		cQuery3 += "AND ( (BD7_FASE = '3') OR (bd7_fase = '4' AND bd7_vlrpag = 0 ) ) " //Adicionado em 24/07/12 por Renato Peixoto para tratar bd7 com fase 4 mas com valor zerado
      		cQuery3 += "AND BD7_BLOPAG <> '1' "
      		cQuery3 += "AND BD7_LOTBLO = ' ' "
      		//cQuery3 += "AND BD7_VLRPAG <> 0 " //se estiver com valor zerado pode trazer tambem para transferir filial. Renato Peixoto em 23/07/12
      		cQuery3 += "AND D_E_L_E_T_ = ' ' "	
      		TCSqlExec(cQuery3)
      		
		EndIf
		
	Else
		lProbBD7 := .T.
		APMSGINFO("Aten��o, houve um problema na transfer�ncia de uma guia das guias selecionadas (BD7). Chave da guia: "+cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4]+". " )
	EndIf
	
	//Grava Log do processamento na PAY
	If !lProbBD5 .AND. !lProbBD6 .AND. !lProbBD7
		RecLock("PAY",.T.)
		PAY->PAY_FILIAL := cFilDest
		PAY->PAY_CODOPE := cCodOpe
		PAY->PAY_CODLDP := aGuias[i][2]
		PAY->PAY_CODPEG := aGuias[i][3]
		PAY->PAY_NUMGUI := aGuias[i][4]
		PAY->PAY_PLANO  := aGuias[i][5]
		PAY->PAY_VLAPRO := aGuias[i][6]
		PAY->PAY_GRPPLA := aGuias[i][7]
		PAY->PAY_NOMPLA := aGuias[i][8]
		//PAY->PAY_REFGUI := aGuias[i][9]
		PAY->PAY_CODRDA := aGuias[i][10]
		PAY->PAY_NOMRDA := aGuias[i][11]
		PAY->PAY_TRANSF := IIF(cTransf = "Transfere","T","R")
		PAY->PAY_DTMOV  := dDataBase
		PAY->PAY_COMPET := cCompet
		PAY->PAY_USUARI := __cUserId
		PAY->PAY_NOMUSR := UsrFullName(__cUserId)
		PAY->PAY_SEQUEN := SeqPAY(cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4])
		PAY->(MsUnlock())
		
		//Adiciono no vetor de guias que foram transferidas com sucesso
		aAdd(aGuiasTran, {cFilDest, cCodOpe+aGuias[i][2]+aGuias[i][3]+aGuias[i][4], aGuias[i][6], aGuias[i][8], aGuias[i][10], aGuias[i][11],;
		 IIF(cTransf = "Transfere","Transfer�ncia","Retorno"), dDataBase, cCompet, __cUserId, AllTrim(UsrFullName(__cUserId)) } )
    EndIf
Next i 

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RelGuiaFat� Autor � Renato Peixoto     � Data �  20/10/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio que vai exibir as guias que nao puderam ser      ���
���          � excluidas porque est�o faturadas ou parcialmente faturadas.���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ.                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RelGuiaFat()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Guias que n�o puderam ser transferidas de filial"
Local cPict          := ""
Local titulo         := "Guias que n�o puderam ser transferidas de filial"
Local nLin           := 80

Local Cabec1         := "Chave Guia (Operadora+Local Digit.+PEG+Guia)        Valor        Cod. RDA       Nome RDA                                     Matricula     Tipo Reg.     Digito    Nome Usu�rio"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RelGuiaFat" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RelGuiaFat" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString      := ""


//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  20/10/11   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nOrdem
Local nTotRel := 0


SetRegua(Len(aGuiasFat))

For i := 1 To Len(aGuiasfat)

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
   
   //"Chave Guia (Operadora+Local Digit.+PEG+Guia)        Valor        Cod. RDA       Nome RDA             Matricula     Tipo Reg.     Digito                 Nome Usu�rio"
   @nLin,00   PSAY aGuiasFat[i][1]
   @nLin,43   PSAY aGuiasFat[i][2] PICTURE "@E 999,999,999.99" 
   @nLin,66   PSAY aGuiasFat[i][6]
   @nLin,78   PSAY aGuiasFat[i][7] 
   @nLin,126  PSAY aGuiasFat[i][8] 
   @nLin,140  PSAY aGuiasFat[i][9] 
   @nLin,155  PSAY aGuiasFat[i][10] 
   @nLin,162  PSAY AllTrim(aGuiasFat[i][11])
   
   nTotRel += aGuiasFat[i][2]
   nLin := nLin + 1 // Avanca a linha de impressao
   
Next i
                        
nLin += 2
@nLin,00 PSAY "Total que n�o p�de ser movimentado: "+AllTrim(Transform(nTotRel,"999,999,999.99"))
//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RelGuiTran� Autor � Renato Peixoto     � Data �  08/11/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio que vai exibir as guias que foram transferidas   ���
���          � de filial com sucesso.                                     ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ.                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RelGuiTran()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Guias que foram transferidas de filial com sucesso."
Local cPict          := ""
Local titulo         := "Guias que foram transferidas de filial"
Local nLin           := 80

Local Cabec1         := "RDA      Nome RDA                                    Plano                  Chave Guia (Operadora+Local Digit.+PEG+Guia)             Valor         Filial Origem       Filial Destino     Usu�rio Respons�vel "
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RelGuiTran" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RelGuiTran" // Coloque aqui o nome do arquivo usado para impressao em disco
                                                
Private cString      := ""


//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport2(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  20/10/11   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport2(Cabec1,Cabec2,Titulo,nLin)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local nOrdem
Local nTotRel := 0


SetRegua(Len(aGuiasTran))

For i := 1 To Len(aGuiasTran)

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8          
   Endif                
   
   @nLin,00   PSAY aGuiasTran[i][5]
   @nLin,08   PSAY aGuiasTran[i][6]
   @nLin,53   PSAY aGuiasTran[i][4]
   @nLin,83   PSAY aGuiasTran[i][2]
   @nLin,124  PSAY aGuiasTran[i][3] PICTURE "@E 999,999,999.99" 
   @nLin,149  PSAY IIF(cFilOri = "  ","Branco",cFilOri)
   @nLin,169  PSAY IIF(cFilDest = "  ","Branco",cFilDest)
   @nLin,186  PSAY UsrFullName(__cUserId)
   
   nTotRel += aGuiasTran[i][3]
   nLin := nLin + 1 // Avanca a linha de impressao

   
Next i

nLin += 2
@nLin,00  PSAY "Total Movimentado: "+ AllTrim(Transform(nTotRel,"999,999,999.99"))
//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � SeqPAY   � Autor � Renato Peixoto        � Data � 08/11/10 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Verifica a ultima sequencia da transferencia/retorno filial���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � SeqPAY()                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function SeqPAY(cChaveGuia)

Local cQuery  := ""
Local cArqQry := GetNextAlias()
Local cSeq    := ""

cQuery := "SELECT MAX(PAY_SEQUEN) SEQ "
cQuery += "FROM "+RetSqlName("PAY")+" PAY "
cQuery += "WHERE D_E_L_E_T_ = ' ' "
cQuery += "AND PAY_FILIAL = '"+cFilDest+"' "
cQuery += "AND PAY_CODOPE||PAY_CODLDP||PAY_CODPEG||PAY_NUMGUI = '"+cChaveGuia+"' "
If cTransf = "Transfere"
	cQuery += "AND PAY_TRANSF = 'T' "
Else
	cQuery += "AND PAY_TRANSF = 'R' "
EndIf

If Select(cArqQry)>0
	(cArqQry)->(DbCloseArea())
EndIf

DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cArqQry,.T.,.T.)

If (cArqQry)->(Eof())
	cSeq := "01"
Else
	cSeq := STRZERO(Val((cArqQry)->SEQ)+1,2)
EndIf

Return(cSeq)



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � CriaSX1  � Autor � Renato Peixoto        � Data � 08/09/10 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Cria/Atualiza perguntas.                                   ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � CriaSX1()                                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function CriaSX1()

PutSx1(cPerg,"01",OemToAnsi("Mes Pgto:")              ,"","","mv_ch1","C",02,0,0,"G","","   ","","","mv_par01",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� o m�s de Pgto no formato mm"},{""},{""})
PutSx1(cPerg,"02",OemToAnsi("Ano Pgto:")              ,"","","mv_ch2","C",04,0,0,"G","","   ","","","mv_par02",""   ,"","","",""   ,"","","","","","","","","","","",{"Defina qual ser� o ano do Pgto no formato aaaa"},{""},{""})
PutSx1(cPerg,"03",OemToAnsi("RDA:")                   ,"","","mv_ch3","C",06,0,0,"G","","BAU","","","mv_par03",""   ,"","","","","","","","","","","","","","","",{"Defina qual ser� o RDA Desejado"},{""},{""})
PutSx1(cPerg,"04",OemToAnsi("Tipo de Processamento:") ,"","","mv_ch4","C",01,0,0,"C","","   ","","","mv_par04","Transferir","","","","Retornar","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Tipo de Guias:")         ,"","","mv_ch5","C",01,0,0,"C","","   ","","","mv_par05","Bloqueadas","","","","Ativa Pronta","","","","","","","","","","","",{},{},{})

Return
