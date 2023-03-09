#include "rwmake.ch"
#include "TOPCONN.CH"
/*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLSR101   ºAutor  ³Alex Faria          º Data ³19/06/2003   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Lista Familia/Usuarios por Empresa Conforme Selecao nos     º±±
±±º          ³Parametros                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteracao ³Criacao de relatorio customizado baseado no fonte padrao    º±±
±±º          ³para corrigir inconsistencias.                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLSRN101()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PRIVATE cString   := "BA3"
PRIVATE cDesc1    := "Listagem de Familia/Usuario por Empresa"
PRIVATE cDesc2    := ""
PRIVATE cDesc3    := ""
PRIVATE limite    := 132
PRIVATE tamanho   := "M"
PRIVATE aReturn   := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
PRIVATE nomeprog  := "PLSR101"
PRIVATE aLinha    := {}
PRIVATE nLastKey  := 0
PRIVATE Titulo    := "Listagem de Familia/Usuario por Empresa"
PRIVATE Cabec1    := "Cod. Operadora      Grupo/Empresa                                               Cod. Contrato            Cod. Sub-Contrato"
PRIVATE Cabec2    := "Cod. Familia         Bl Nome Usuario                    Tp. Dep     Sexo       Est.Civil       CPF Usuario     Dt.Incl.   Dt. Nasc."
PRIVATE cCancel   := "***** CANCELADO PELO OPERADOR *****"
PRIVATE m_pag     := 1  // numero da pagina
PRIVATE cPerg     := "PLR101"   
PRIVATE pag       := 1
PRIVATE li        := 80
PRIVATE wnRel     := "PLSR101"
PRIVATE lAbortPrint := .F.
PRIVATE cMatAnD	  
PRIVATE cMatAnA    
PRIVATE lImpMaA    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe janela padrao de relatorios                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()
wnRel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza Parametros com Pergunte PLSR101                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("PLR101",.F.)

dDatBas    := mv_par11
cMatAnD	   := mv_par12
cMatAnA    := mv_par13
lImpMaA    := If(mv_par14==1,.t.,.f.)

If  nLastKey == 27
    Set Filter To
    Return
Endif

SetDefault(aReturn,cString)

MsAguarde({|| PLSR101IMP() }, "Listagem de Familia/Usuario", "", .T.)

If  nLastKey == 27
    Set Filter To
    Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera spool de impressao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Roda(0,"","M")

Set Filter To

If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif

MS_FLUSH()             // Libera fila de relatorios em spool

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³PLSR101IMP ³ Autor ³                       ³ Data ³         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Prepara Relatorio para Ser Impresso                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                               
Static Function PLSR101IMP()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL aTotEmp    := 0
LOCAL aTotUsr    := 0
LOCAL aEmpr      := 0
LOCAL aQtdFam    := 0
LOCAL aQtdUsr    := 0
LOCAL dDatBas       := mv_par11

MsProcTxt("Processado Arquivos de Familia ...")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa Query no Arquivo BA3(CADASTRO DE FAMILIA)                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aQuery := " SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP, BA3_SUBCON, BA3_MATRIC, BA3_TIPCON, BA3_MOTBLO, BA3_MATANT,"
aQuery += " SUBSTRING(BA3_DATCON,7,2)+'/'+SUBSTRING(BA3_DATCON,5,2)+'/'+SUBSTRING(BA3_DATCON,1,4) BA3_DATCON "
aQuery += " FROM " +RetSqlName("BA3")
aQuery += " WHERE "
aQuery += " BA3_FILIAL =  '"+xFilial("BA3")+"' AND "
aQuery += " BA3_CODINT =  '"+mv_par01+"' AND "
aQuery += " BA3_CODEMP >= '"+mv_par02+"' AND "
aQuery += " BA3_CODEMP <= '"+mv_par03+"' AND "
aQuery += " BA3_CONEMP >= '"+mv_par04+"' AND "
aQuery += " BA3_CONEMP <= '"+mv_par05+"' AND "
aQuery += " BA3_SUBCON >= '"+mv_par06+"' AND "
aQuery += " BA3_SUBCON <= '"+mv_par07+"' AND "
aQuery += " BA3_MATRIC >= '"+mv_par08+"' AND "
aQuery += " BA3_MATRIC <= '"+mv_par09+"' AND "

aQuery += "	BA3_DATBAS <='"+DTOS(dDatBas)+"' AND "
                          

If !Empty(cMatAnA)
	aQuery += " BA3_MATANT >= '"+cMatAnD+"' AND "
	aQuery += " BA3_MATANT <= '"+cMatAnA+"' AND "	
Endif

aQuery += " D_E_L_E_T_ = '' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona Registros de Familia Bloqueados ou Nao Conforme Pergunte                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par10 = 2   // BLOQUEADOS

   aQuery += "AND (BA3_DATBLO <> '   ' AND BA3_DATBLO <='"+DTOS(dDatBas)+"') "

Elseif mv_par10 = 3 //ATIVOS

   aQuery += "AND (BA3_DATBLO = '   ' OR BA3_DATBLO >'"+DTOS(dDatBas)+"') "

Endif     

If ! Empty(aReturn[7])
     aQuery += " AND " + ParSQL(Upper(aReturn[7]))
Endif                            

aQuery += " ORDER BY BA3_CONEMP, BA3_SUBCON, BA3_CODEMP, BA3_MATRIC"

PLSQuery(aQuery,"QRA")

DbSelectArea("QRA")

If  li >= 58
    cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
EndIf

aEmpr := Substr(Posicione("BG9",1,xFilial("BG9")+QRA->BA3_CODINT+QRA->BA3_CODEMP,"BG9_DESCRI"),1,28)//+QRA->BA3_TIPCON,"BG9_DESCRI"),1,28)

@ li,000 Psay "Operadora.:"
@ li,012 Psay QRA->BA3_CODINT
@ li,021 Psay "Grupo/Empresa.:"
@ li,038 Psay QRA->BA3_CODEMP
@ li,045 Psay aEmpr
@ li,081 Psay "Contrato.:"
@ li,092 Psay QRA->BA3_CONEMP
@ li,106 Psay "Sub-Contrato.:"
@ li,121 Psay QRA->BA3_SUBCON
li := li + 2

aCdEmpr  := QRA->BA3_CODEMP
aCdCont  := QRA->BA3_CONEMP
aCdSubCo := QRA->BA3_SUBCON

While ! QRA->(EOF())
   
    MsProcTXT("Imprimindo Usuarios da Familia.: "+QRA->BA3_CODINT+"."+QRA->BA3_CODEMP+"."+QRA->BA3_MATRIC)

    If Interrupcao(lAbortPrint)
       li++
       @ li,000 pSay "ABORTADO PELO USUARIO"
       Exit
    Endif 

    If  li >= 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))	
	EndIf

	If aCdEmpr <> QRA->BA3_CODEMP
        MsProcTXT("Processando Nova Empresa.: "+QRA->BA3_CODEMP)
		@ li,000 Psay Replicate("-",132)
        ++li
		@ li,003 Psay "Total da Empresa.:" 
		@ li,022 Psay aCdEmpr
        @ li,028 Psay aEmpr 
        @ li,082 Psay "Qtd. Familias.:"
        @ li,098 Psay aQtdFam
        @ li,108 Psay "Qtd. Usuarios.:"
        @ li,124 Psay aQtdUsr
        ++li
		@ li,000 Psay Replicate("-",132)
		li := li+2
		
        aTotEmp := aTotEmp + 1
		aQtdFam := 0
		aQtdUsr := 0

        @ li,000 Psay "Operadora.:"
        @ li,012 Psay QRA->BA3_CODINT
        @ li,021 Psay "Grupo/Empresa.:"
        @ li,038 Psay QRA->BA3_CODEMP
        @ li,045 Psay Substr(Posicione("BG9",1,xFilial("BG9")+QRA->BA3_CODINT+QRA->BA3_CODEMP+QRA->BA3_TIPCON,"BG9_DESCRI"),1,28)
        @ li,081 Psay "Contrato.:"
        @ li,092 Psay QRA->BA3_CONEMP
        @ li,106 Psay "Sub-Contrato.:"
        @ li,121 Psay QRA->BA3_SUBCON
		li := li + 2
		aCdEmpr := QRA->BA3_CODEMP
        aEmpr := Substr(Posicione("BG9",1,xFilial("BG9")+QRA->BA3_CODINT+QRA->BA3_CODEMP,"BG9_DESCRI"),1,28)//+QRA->BA3_TIPCON,"BG9_DESCRI"),1,28)
	Else
	    If aCdCont <> QRA->BA3_CONEMP
           @ li,081 Psay "Contrato.:"
           @ li,092 Psay QRA->BA3_CONEMP
           @ li,106 Psay "Sub-Contrato.:"
           @ li,121 Psay QRA->BA3_SUBCON
           li++
           @ li,000 Psay Replicate("-",132)
    	   li := li + 2
    	   aCdCont  := QRA->BA3_CONEMP
    	   aCdSubCo := QRA->BA3_SUBCON
    	ElseIf aCdSubCo <> QRA->BA3_SUBCON  
           @ li,081 Psay "Contrato.:"
           @ li,092 Psay QRA->BA3_CONEMP
           @ li,106 Psay "Sub-Contrato.:"
           @ li,121 Psay QRA->BA3_SUBCON
           li++
           @ li,000 Psay Replicate("-",132)
    	   li := li + 2
           aCdCont := QRA->BA3_CONEMP
    	   aCdSubCo := QRA->BA3_SUBCON    	   
    	Endif       	
	Endif    
  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa Query no Arquivo BA1(CADASTRO DE USUARIOS)                                  ³
//³Pesquisa BA1(Usuarios) De Acordo Com os Registros Selecionados no BA3(Familia)      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	bQuery := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_CONEMP, BA1_SUBCON,"
	bQuery += " BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, BA1_TIPUSU, BA1_SEXO, BA1_ESTCIV,"
	bQuery += " BA1_CPFUSR, BA1_DATBLO, BA1_MOTBLO,BA1_NUMCON, BA1_MOTBLO, "
	bQuery += " BA1_DATINC, BA1_DATNAS, BA1_MATANT "
	bQuery += " FROM "+RetSqlName("BA1")
	bQuery += " WHERE"
	bQuery += " BA1_CODINT = '"+QRA->BA3_CODINT+"' AND "
	bQuery += " BA1_CONEMP = '"+QRA->BA3_CONEMP+"' AND "
	bQuery += " BA1_SUBCON = '"+QRA->BA3_SUBCON+"' AND "
	bQuery += " BA1_CODEMP = '"+QRA->BA3_CODEMP+"' AND "
	bQuery += " BA1_MATRIC = '"+QRA->BA3_MATRIC+"' AND "
	
	bQuery += "	BA1_DATINC <='"+DTOS(dDatBas)+"' AND "
	
	bQuery += " D_E_L_E_T_ = ''"      

    If mv_par10 = 2  //BLOQUEADOS
   
       bQuery += "AND (BA1_DATBLO <> '        ' AND BA1_DATBLO <='"+DTOS(dDatBas)+"') "

    ElseIf mv_par10 = 3  //ATIVOS
   
       bQuery += "AND (BA1_DATBLO = '        ' OR BA1_DATBLO >'"+DTOS(dDatBas)+"') "

    Endif     
	
	bQuery += " ORDER BY BA1_CONEMP, BA1_SUBCON, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
	
	PLSQuery(bQuery,"QRB")
	
	DbSelectArea("QRB")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se a Query Esta Vazia ou Nao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If QRB->(BOF()) .AND. QRB->(EOF())
       li++
       If !lImpMaA
	       @ li,000 Psay QRA->BA3_CODINT+"."+QRA->BA3_CODEMP+"."+QRA->BA3_MATRIC
       Else
           @ li,000 Psay QRA->BA3_MATANT
       Endif
       @ li,030 Psay "------  NAO HA USUARIOS CADASTRADOS PARA ESTA FAMILIA. ------"
       li := li + 2
       aQtdFam := aQtdFam + 1
       QRB->(DbcloseArea())
	   QRA->(Dbskip())
	   Loop
	Endif   

    aQtdFam := aQtdFam + 1 

	If !lImpMaA
		@ li,000 Psay QRB->BA1_CODINT+"."+QRB->BA1_CODEMP+"."+QRB->BA1_MATRIC+"."+QRB->BA1_TIPREG+"-"+QRB->BA1_DIGITO
    Else
    	@ li,000 Psay QRB->BA1_MATANT
    Endif   
	@ li,022 Psay IIf(Alltrim(QRB->BA1_MOTBLO)<>"","*"," ")
	@ li,024 Psay Substr(QRB->BA1_NOMUSR,1,30)
	@ li,056 Psay Substr(Posicione("BIH",1,xFilial("BIH")+QRB->BA1_TIPUSU,"BIH_DESCRI"),1,10)
	@ li,068 Psay X3Combo("BA1_SEXO",QRB->BA1_SEXO)
	@ li,079 Psay Substr(Posicione("SX5",1,xFilial("SX5")+"33"+QRB->BA1_ESTCIV,"X5_DESCRI"),1,15)
	@ li,095 Psay QRB->BA1_CPFUSR Picture X3Picture("BA1_CPFUSR",QRB->BA1_CPFUSR)
	@ li,111 Psay QRB->BA1_DATINC
	@ li,122 Psay QRB->BA1_DATNAS
	li++
	QRB->(DbSkip())
 
    aTotUsr := aTotUsr + 1	
    aQtdUsr := aQtdUsr + 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprimi os Usuarios Relacionados de Acordo Com a Familia                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	While ! QRB->(EOF()) 
		If  li >= 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
        	If !lImpMaA
        		@ li,000 Psay QRB->BA1_CODINT+"."+QRB->BA1_CODEMP+"."+QRB->BA1_MATRIC+"."
			Else
        		@ li,000 Psay QRB->BA1_MATANT
			Endif
		EndIf
		@ li,017 Psay QRB->BA1_TIPREG+"-"+QRB->BA1_DIGITO
        @ li,022 Psay IIf(Alltrim(QRB->BA1_MOTBLO)<>"","*"," ")
		@ li,024 Psay Substr(QRB->BA1_NOMUSR,1,30)
		@ li,056 Psay Substr(Posicione("BIH",1,xFilial("BIH")+QRB->BA1_TIPUSU,"BIH_DESCRI"),1,10)
		@ li,068 Psay X3Combo("BA1_SEXO",QRB->BA1_SEXO)
		@ li,079 Psay Substr(Posicione("SX5",1,xFilial("SX5")+"33"+QRB->BA1_ESTCIV,"X5_DESCRI"),1,15)
		@ li,095 Psay QRB->BA1_CPFUSR Picture X3Picture("BA1_CPFUSR",QRB->BA1_CPFUSR)
		@ li,111 Psay QRB->BA1_DATINC
		@ li,122 Psay QRB->BA1_DATNAS  
		li++
		QRB->(DbSkip())
        aTotUsr := aTotUsr + 1	
        aQtdUsr := aQtdUsr + 1
	Enddo
	li++
	QRB->(DbCloseArea())
	QRA->(DbSkip())
//	IncRegua()
Enddo

aTotEmp := aTotEmp + 1

@ li,000 Psay Replicate("-",132)
++li
@ li,003 Psay "Total da Empresa.:" 
@ li,022 Psay aCdEmpr
@ li,028 Psay aEmpr 
@ li,082 Psay "Qtd. Familias.:"
@ li,098 Psay aQtdFam
@ li,108 Psay "Qtd. Usuarios.:"
@ li,124 Psay aQtdUsr
++li
@ li,000 Psay Replicate("-",132)
li := li+2                                                  

@ li,049 Psay "--------- TOTAIS DO RELATORIO -----------"
++li
@ li,052 Psay "Numero de Empresas Impressas.:"
@ li,083 Psay aTotEmp
++li
@ li,052 Psay "Numero de Usuarios Impressos.:"
@ li,083 Psay aTotUsr
++li
@ li,049 Psay "-----------------------------------------"

QRA->(DbCloseArea())

Return

Static Function ParSQL(cFilADV)
 
cFilADV := StrTran(cFilADV,".AND."," AND ")
cFilADV := StrTran(cFilADV,".OR."," OR ")
cFilADV := StrTran(cFilADV,"=="," = ")
cFilADV := StrTran(cFilADV,'"',"'")
cFilADV := StrTran(cFilADV,'$'," IN ")
cFilADV := StrTran(cFilADV,"ALLTRIM","  ")
 
Return(cFilADV)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIASX1   ºAutor  ³ Otacilio A. Junior º Data ³ 19/06/2007  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Altera Pergunta caso o tamanho da pergunta de contrato sejaº±±
±±º          ³ menor que 12                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaSX1()

Local aRegs	:=	{}
SX1->(DbSetOrder(1))
If SX1->(DbSeek(Padr(cPerg,Len(SX1->X1_GRUPO))+"06"))
	If SX1->X1_TAMANHO = 11
	   SX1->(DbSeek(cPerg))
	   While Alltrim(SX1->X1_GRUPO) == cPerg
	      RecLock("SX1",.F.)
	      SX1->(DbDelete())
	      SX1->(MsUnlock())
	      SX1->(DbSkip())
	   End
	EndIf
EndIf

aadd(aRegs,{cPerg,"01","Operadora De ?                ","¿De operadora ?               ","From operator ?               ","mv_ch1","C",04,0,0,"G","","mv_par01",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B89PLS", "B89"),"N","","","",""})
aadd(aRegs,{cPerg,"02","Empresa De ?                  ","¿De empresa ?                 ","From company ?                ","mv_ch2","C",04,0,0,"G","","mv_par02",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7APLS", "B7A"),"N","","","",""})
aadd(aRegs,{cPerg,"03","Empresa Ate ?                 ","¿A empresa ?                  ","To company ?                  ","mv_ch3","C",04,0,0,"G","","mv_par03",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7APLS", "B7A"),"N","","","",""})
aadd(aRegs,{cPerg,"04","Contrato De ?                 ","¿De contrato ?                ","From contract ?               ","mv_ch4","C",12,0,0,"G","","mv_par04",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7BPLS", "B7B"),"N","","","",""})
aadd(aRegs,{cPerg,"05","Contrato Ate ?                ","¿A contrato ?                 ","To contract ?                 ","mv_ch5","C",12,0,0,"G","","mv_par05",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7BPLS", "B7B"),"N","","","",""})
aadd(aRegs,{cPerg,"06","Sub-Contrato De ?             ","¿De sub contrato ?            ","From sub-contract ?           ","mv_ch6","C",09,0,0,"G","","mv_par06",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7CPLS", "B7C"),"N","","","",""})
aadd(aRegs,{cPerg,"07","Sub-Contrato Ate ?            ","¿A sub contrato ?             ","To sub-contract ?             ","mv_ch7","C",09,0,0,"G","","mv_par07",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7CPLS", "B7C"),"N","","","",""})
aadd(aRegs,{cPerg,"08","Familia De ?                  ","¿De familia ?                 ","From family ?                 ","mv_ch8","C",06,0,0,"G","","mv_par08",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"09","Familia Ate ?                 ","¿A familia ?                  ","To family ?                   ","mv_ch9","C",06,0,0,"G","","mv_par09",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"10","Imprime Somente Fam ?         ","¿Imprimir solo familia ?      ","Print family only ?           ","mv_ch0","C",01,0,1,"C","","mv_par10","Todos","Todos","All","","","Bloqueados","Bloqueados","Blocked","","","Nao bloqueados","Sin bloquear","Not blocked","","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"11","Data Referencia ?             ","¿Fecha de referencia ?        ","Reference date ?              ","mv_cha","D",08,0,0,"G","","mv_par11",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"12","Matr. Antiga de ?             ","¿De matric.antigua ?          ","To registration ?             ","mv_chc","C",17,0,0,"G","","mv_par12",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"13","Matr. Antiga ate ?            ","¿A matric.antigua ?           ","From old registration ?       ","mv_chd","C",17,0,0,"G","","mv_par13",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
aadd(aRegs,{cPerg,"14","Imp. Matr. Antiga?            ",""                              ,""                              ,"mv_che","N",01,0,1,"C","","mv_par14","Sim"  ,"Si"   ,"Yes","","","Nao"       ,"No"        ,"No"     ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})

PlsVldPerg( aRegs )

Return
