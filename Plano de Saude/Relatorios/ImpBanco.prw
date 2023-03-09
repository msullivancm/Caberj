#INCLUDE "rwmake.ch"
#INCLUDE "TopConn.ch"


User Function ImpArqBc
//Local aFiles := {}
//LOCAL I
//LOCAL aCampoTRB := {{"TR1_CODIGO"    	, "C", 450	, 0 }}
Private cOrigem  := "C:\Caberj\*.*"
Private lColegio := .F.
Private oDlg     := Nil
Private dData    := dDatabase
Private cArqTxt  := "C:\Caberj\*.*"

Private nHdl
Private cEOL

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria o Arquivo de Trabalho que armazenara os valores por produto...      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
/*
cArqTRB := CriaTrab(aCampoTRB, .T.)

dbUseArea(.T.,,cArqTRB,"TRB1",.F.)
Adir(Alltrim(cArqTxt),aFiles)
Asort(aFiles)
                        
dbSelectArea("TRB1")
For I=1 To Len(aFiles)
	xArquivo  := "C:\Caberj\"+aFiles[I]
	
	
	Append from &xArquivo SDF
	
Next           

TRB1->( dbGotop() )
*/

cSql := "SELECT R_E_C_N_O_ REC FROM SE5010 "
cSql += "WHERE E5_FILIAL = '01' AND E5_OPERAD <> ' ' AND D_E_L_E_T_ = ' ' "
cSql += "ORDER BY E5_DATA "
//AND E5_PREFIXO = 'PLS' AND E5_NUMERO = '072047' 
PlsQuery(cSql, "TRB")

//SE1->( dbSetorder(19) )
SE1->(DBOrderNickName("SE1NOSNUM"))
SE5->( dbSetorder(07) )
While !Trb->( Eof() )
/*
	If Substr(TRB1->TR1_CODIGO, 1, 1) == '1'
		cNumTit	:= SubStr(TRB1->TR1_CODIGO, 63, 8)
		dData		:= cTod((SubStr(TRB1->TR1_CODIGO,296, 2) + '/'+ SubStr(TRB1->TR1_CODIGO, 298,2)+'/'+SubStr(TRB1->TR1_CODIGO,300,2)))
		
		If Empty(dData)
			dData := cTod((SubStr(TRB1->TR1_CODIGO,111, 2)+'/'+SubStr(TRB1->TR1_CODIGO,113,2)+'/'+SubStr(TRB1->TR1_CODIGO,115,2)))
			
			dData := DataValida(dData+1)
		Endif
		
		If SE1->( dbSeek(xFilial("SE1") + cNumTit) )
			If SE5->( dbSeek(xFilial("SE5") + SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)) )
			
				While !SE5->( Eof() ) .and. SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO) ==;
													 SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) 
					SE5->(RecLock("SE5", .F.))
						SE5->E5_OPERAD := DTOC(SE5->E5_DTDISPO)
						SE5->E5_DTDISPO := dData
					SE5->( MsUnlock() )
					
					SE5->( dbSkip() )
				Enddo
			Endif
		Endif
	Endif
*/
      
	SE5->( dbGoto(TRB->REC) )
	If !SE5->( Eof() )
		dData := DataValida(SE5->E5_DATA+1)
		SE5->(RecLock("SE5", .F.))
//			SE5->E5_OPERAD := DTOC(SE5->E5_DTDISPO)
			SE5->E5_NUMCHEQ := DTOC(SE5->E5_DTDISPO)
			SE5->E5_DTDISPO := dData
		SE5->( MsUnlock() )
	Endif
						
	TRB->( dbSkip() )
Enddo

TRB->( dbCloseArea() )
Return

