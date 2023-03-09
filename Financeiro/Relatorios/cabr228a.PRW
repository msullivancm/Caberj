#INCLUDE "rwmake.ch" 
#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
#include "PLSMGER.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR228A  º Autor ³ AP6 IDE           º Data ³  25/11/16    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR228A(cEmpInc , cEmpFim , cComptInc, cComptFim )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := " de acordo com os parametros informados pelo usuario."
Local cDesc3         := " usuarios vinculados pelo CPF que participaram na    "
Local cPict          := " CABERJ  e na INTEGRAL com o mesmo CPF               "
Local titulo         := " Não e Considerado condição de bloqueio  "
Local nLin           := 80
                                                                                                                                      
Local Cabec1         := "           Matritulas  Bloq      Usuarios             Dt Incl   Dt Bloq   Cpf          MatVida     Vlr Mensal  %     Vlr Comissao    Compt Dias   Vendedor"

Local Cabec2         := "           Matritulas  Ativ      Usuarios             Dt Incl   Dt Bloq   Cpf          MatVida     Vlr Mensal  %     Vlr Comissao    Compt        Vendedor                 %     Vlr Com Devido  Ajuste a Fazer   Parc "    
      //                   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
      //                            1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        20         3         4

Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "cabr228A" // Coloque aqui o nome do programa para impressao no cabecalho      
private cPerg        := "CABR228A"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR228A" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "BA1"     


Private cAliastmp 	:= GetNextAlias()
Private cAliasATU 	:= GetNextAlias()        
Private cAliasANT 	:= GetNextAlias() 
Private cAliasAJT 	:= GetNextAlias()                           

private cCodEmpI := cEmpInc
private cCodEmpF := cEmpFim
private cCompetI := cComptInc  	   
private cCompetF := cComptFim      
                                                 
private ctraco   := replicate("_",220) 

private nbscomant  :=0
private nvlcomant  :=0
private nbascomatu :=0
private nvlcomatu  :=0
private nvlrccert  :=0
private ndifdev    :=0                  
private nvlrccertt :=0
private ndifdevt   :=0                  

private ccodven    := ' '  
private cMatVid1   := ' ' 
private lfaz       :=.F.                

if empty(cEmpInc)
   AjustaSX1(cPerg)

 cCodEmpI := mv_par01
 cCodEmpF := mv_par02
 cCompetI := mv_par03  	   
 cCompetF := mv_par04  

endIf        


dbSelectArea("BA1")
dbSetOrder(1)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  25/11/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem

dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicionamento do primeiro registro e loop principal. Pode-se criar ³
//³ a logica da seguinte maneira: Posiciona-se na filial corrente e pro ³
//³ cessa enquanto a filial do registro for a filial corrente. Por exem ³
//³ plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    ³
//³                                                                     ³
//³ dbSeek(xFilial())                                                   ³
//³ While !EOF() .And. xFilial() == A1_FILIAL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
ProcRegua(FT_FLASTREC()) 

nCont := 0                          

IncProc('Processando , buscando dados no servidor ........ ')     

//--------
//---  MATRICULAS ENVOLVIDAS  
//--------
/*cquery := CRLF+"     SELECT Distinct BA11.BA1_MATVID MATVIDANT, "
cquery += CRLF+"            SIGA.FORMATA_MATRICULA_MS( TRIM(BA11.BA1_CODINT)||TRIM(BA11.BA1_CODEMP)||TRIM(BA11.BA1_MATRIC)||TRIM(BA11.BA1_TIPREG)||TRIM(BA11.BA1_DIGITO)) MAT_ANT , "
cquery += CRLF+"            TRIM(BA11.BA1_CODINT)CODINTANT , "
cquery += CRLF+"            TRIM(BA11.BA1_CODEMP)CEMPANT , "
cquery += CRLF+"            TRIM(BA11.BA1_MATRIC)MATCANT , "
cquery += CRLF+"            TRIM(BA11.BA1_TIPREG)TPRGANT , "
cquery += CRLF+"            SUBSTR(BA11.BA1_NOMUSR,1,20) NOME_ANT , "
cquery += CRLF+"            TO_DATE( BA11.BA1_DATINC, 'YYYYMMDD') INC_ANT ,  "
cquery += CRLF+"            TO_DATE(TRIM(BA11.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ANT , "
cquery += CRLF+"            BA11.BA1_CPFUSR CPFANT ,  "                                                          
cquery += CRLF+"            DECODE(NVL(BXQ1.BXQ_CODVEN,' ' ),' ', 'Sem Agenc', 'Com Agenc')   AGENCANT ,                                                        
cquery += CRLF+"            TO_DATE (BA12.BA1_DATINC,'YYYYMMDD') - TO_DATE(BA11.BA1_DATBLO,'YYYYMMDD') dias ,"                         
cquery += CRLF+"            BA12.BA1_MATVID MATVIDATU, "
cquery += CRLF+"            SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO)) MAT_ATU , "
cquery += CRLF+"            TRIM(BA12.BA1_CODINT)CODINTATU , "
cquery += CRLF+"            TRIM(BA12.BA1_CODEMP)CEMPATU , "
cquery += CRLF+"            TRIM(BA12.BA1_MATRIC)MATCATU , "
cquery += CRLF+"            TRIM(BA12.BA1_TIPREG)TPRGATU , "
cquery += CRLF+"            SUBSTR(BA12.BA1_NOMUSR,1,20) NOME_ATU , "
cquery += CRLF+"            TO_DATE( BA12.BA1_DATINC, 'YYYYMMDD') INC_ATU , "
cquery += CRLF+"            TO_DATE(TRIM(BA12.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ATU , "
cquery += CRLF+"            BA12.BA1_CPFUSR CPFATU , "
cquery += CRLF+"            DECODE(NVL(BXQ2.BXQ_CODVEN,' ' ),' ', 'Sem Agenc', 'Com Agenc') AGENCATU , "
cquery += CRLF+"            'MV ' origem "
                                                        
cquery += CRLF+"     FROM "+ RetSqlName("BA1") + " BA11 ,"+ RetSqlName("BA1") + " BA12 ,"           
cquery += CRLF+"         " + RetSqlName("BXQ") + " BXQ1 ,"+ RetSqlName("BXQ") + " BXQ2  "           
 
cquery += CRLF+"    WHERE BA11.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA11.D_e_l_e_t_ = ' ' "
cquery += CRLF+"      AND BA12.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA12.D_e_l_e_t_ = ' ' "
 
cquery += CRLF+"      AND BXQ1.BXQ_FILIAL(+) = '" + xFilial('BXQ') + "' AND BXQ1.D_e_l_e_t_(+) = ' ' "
cquery += CRLF+"      AND BXQ2.BXQ_FILIAL(+) = '" + xFilial('BXQ') + "' AND BXQ2.D_e_l_e_t_(+) = ' ' "
     
cquery += CRLF+"      AND BA11.BA1_MATVID  =  BA12.BA1_MATVID "
cquery += CRLF+"      AND BA11.BA1_DATBLO <> ' ' "
cquery += CRLF+"      AND BA11.BA1_DATINC < BA12.BA1_DATINC "
                                                                
cquery += CRLF+"      AND BA12.BA1_CODEMP >='"+cCodEmpI+"' AND BA12.BA1_codemp <= '"+cCodEmpF+"' "

cquery += CRLF+"      AND substr(BA12.BA1_DATINC,1,6) >= '"+cCompetI+"' " 
cquery += CRLF+"      AND substr(BA12.BA1_DATINC,1,6) <= '"+cCompetF+"' "

cquery += CRLF+"      AND TO_DATE (BA12.BA1_DATINC,'YYYYMMDD') - TO_DATE(BA11.BA1_DATBLO,'YYYYMMDD') <= 180 "
cquery += CRLF+"      AND BA11.R_E_C_N_O_ <> BA12.R_E_C_N_O_ "   

cquery += CRLF+"      AND BXQ1.BXQ_CODEMP(+) = BA11.BA1_CODEMP "
cquery += CRLF+"      AND BXQ1.BXQ_MATRIC(+) = BA11.BA1_MATRIC "
cquery += CRLF+"      AND BXQ1.BXQ_TIPREG(+) = BA11.BA1_TIPREG "
cquery += CRLF+"      AND BXQ1.BXQ_REFERE(+) = BXQ1.BXQ_PAGCOM(+) " 
cquery += CRLF+"      AND BXQ1.BXQ_PERCOM(+) > 10 "
cquery += CRLF+"      AND BXQ1.BXQ_BASCOM(+) > 0  "
      
cquery += CRLF+"      AND BXQ2.BXQ_CODEMP(+) = BA12.BA1_CODEMP "
cquery += CRLF+"      AND BXQ2.BXQ_MATRIC(+) = BA12.BA1_MATRIC "
cquery += CRLF+"      AND BXQ2.BXQ_TIPREG(+) = BA12.BA1_TIPREG "
cquery += CRLF+"      AND BXQ2.BXQ_REFERE(+) = BXQ2.BXQ_PAGCOM(+) "
cquery += CRLF+"      AND BXQ2.BXQ_PERCOM(+) > 10 "
cquery += CRLF+"      AND BXQ2.BXQ_BASCOM(+) > 0  "
                            
cquery += CRLF+"   union  " 
*/
cquery := CRLF+"     SELECT Distinct BA11.BA1_MATVID MATVIDANT, "
cquery += CRLF+"            SIGA.FORMATA_MATRICULA_MS( TRIM(BA11.BA1_CODINT)||TRIM(BA11.BA1_CODEMP)||TRIM(BA11.BA1_MATRIC)||TRIM(BA11.BA1_TIPREG)||TRIM(BA11.BA1_DIGITO)) MAT_ANT , "
cquery += CRLF+"            TRIM(BA11.BA1_CODINT)CODINTANT , "
cquery += CRLF+"            TRIM(BA11.BA1_CODEMP)CEMPANT , "
cquery += CRLF+"            TRIM(BA11.BA1_MATRIC)MATCANT , "
cquery += CRLF+"            TRIM(BA11.BA1_TIPREG)TPRGANT , "
cquery += CRLF+"            SUBSTR(BA11.BA1_NOMUSR,1,20) NOME_ANT , "
cquery += CRLF+"            TO_DATE( BA11.BA1_DATINC, 'YYYYMMDD') INC_ANT ,  "
//cquery += CRLF+"          TO_DATE(TRIM(BA11.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ANT , "
cquery += CRLF+"            TRIM(BA11.BA1_DATBLO) BLOQ_ANT , "
cquery += CRLF+"            BA11.BA1_CPFUSR CPFANT ,  "                                                          
cquery += CRLF+"            DECODE(NVL(BXQ1.BXQ_CODVEN,' ' ),' ', 'Sem Agenc', 'Com Agenc')   AGENCANT ,                                                        
//cquery += CRLF+"          TO_DATE (BA12.BA1_DATINC,'YYYYMMDD') - TO_DATE(BA12.BA1_DATBLO,'YYYYMMDD') dias ,"            
cquery += CRLF+"             BXQ1.BXQ_bascom bascom1 , BXQ1.bxq_percom percom1 , BXQ1.bxq_vlrcom vlrcom1 , "

cquery += CRLF+"            '??' dias ,"                   
cquery += CRLF+"            BA12.BA1_MATVID MATVIDATU, "
cquery += CRLF+"            SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO)) MAT_ATU , "
cquery += CRLF+"            TRIM(BA12.BA1_CODINT)CODINTATU , "
cquery += CRLF+"            TRIM(BA12.BA1_CODEMP)CEMPATU , "
cquery += CRLF+"            TRIM(BA12.BA1_MATRIC)MATCATU , "
cquery += CRLF+"            TRIM(BA12.BA1_TIPREG)TPRGATU , "
cquery += CRLF+"            SUBSTR(BA12.BA1_NOMUSR,1,19) NOME_ATU , "
cquery += CRLF+"            TO_DATE( BA12.BA1_DATINC, 'YYYYMMDD') INC_ATU , "
//cquery += CRLF+"            TO_DATE(TRIM(BA12.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ATU , " 
cquery += CRLF+"            TRIM(BA12.BA1_DATBLO) BLOQ_ATU , "                                       
cquery += CRLF+"            BA12.BA1_CPFUSR CPFATU , "
cquery += CRLF+"            DECODE(NVL(BXQ2.BXQ_CODVEN,' ' ),' ', 'Sem Agenc', 'Com Agenc') AGENCATU , "
cquery += CRLF+"            BXQ2.BXQ_bascom bascom2 , BXQ2.bxq_percom percom2 , BXQ2.bxq_vlrcom vlrcom2 , "
cquery += CRLF+"            'CPF' origem "
                                                        
cquery += CRLF+"     FROM BA1010 BA11 ,BA1020 BA12 ,"           
cquery += CRLF+"          BXQ010 BXQ1 ,BXQ020 BXQ2  "           
 
cquery += CRLF+"    WHERE BA11.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA11.D_e_l_e_t_ = ' ' "
cquery += CRLF+"      AND BA12.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA12.D_e_l_e_t_ = ' ' "
 
cquery += CRLF+"      AND BXQ1.BXQ_FILIAL(+) = '" + xFilial('BXQ') + "' AND BXQ1.D_e_l_e_t_(+) = ' ' "
cquery += CRLF+"      AND BXQ2.BXQ_FILIAL(+) = '" + xFilial('BXQ') + "' AND BXQ2.D_e_l_e_t_(+) = ' ' "
     
//cquery += CRLF+"      AND BA11.BA1_MATVID <> BA12.BA1_MATVID "   
cquery += CRLF+"      AND BA11.BA1_CPFUSR <> ' ' AND BA11.BA1_CPFUSR <> '99999999999' " 
cquery += CRLF+"      AND BA11.BA1_CPFUSR =  BA12.BA1_CPFUSR 
//cquery += CRLF+"      AND BA11.BA1_DATNAS =  BA12.BA1_DATNAS
//cquery += CRLF+"      AND BA11.BA1_DATBLO <> ' ' "
//cquery += CRLF+"      AND BA11.BA1_DATINC <  BA12.BA1_DATINC " 

cquery += CRLF+"      AND BA11.BA1_CODEMP <> '0004' "                                                                
cquery += CRLF+"      AND BA11.BA1_CODEMP >='"+cCodEmpI+"' AND BA11.BA1_codemp <= '"+cCodEmpF+"' "

cquery += CRLF+"      AND substr(BA11.BA1_DATINC,1,6) >= '"+cCompetI+"' " 
cquery += CRLF+"      AND substr(BA11.BA1_DATINC,1,6) <= '"+cCompetF+"' "

//cquery += CRLF+"      AND TO_DATE (BA12.BA1_DATINC,'YYYYMMDD') - TO_DATE(BA11.BA1_DATBLO,'YYYYMMDD') <= 180 "
//cquery += CRLF+"      AND BA11.R_E_C_N_O_ <> BA12.R_E_C_N_O_ "   

cquery += CRLF+"      AND BXQ1.BXQ_CODEMP = BA11.BA1_CODEMP "
cquery += CRLF+"      AND BXQ1.BXQ_MATRIC = BA11.BA1_MATRIC "
cquery += CRLF+"      AND BXQ1.BXQ_TIPREG = BA11.BA1_TIPREG "
cquery += CRLF+"      AND BXQ1.BXQ_REFERE = BXQ1.BXQ_PAGCOM " 
cquery += CRLF+"      AND BXQ1.BXQ_PERCOM > 10 "
cquery += CRLF+"      AND BXQ1.BXQ_BASCOM > 0  "
      
cquery += CRLF+"      AND BXQ2.BXQ_CODEMP = BA12.BA1_CODEMP "
cquery += CRLF+"      AND BXQ2.BXQ_MATRIC = BA12.BA1_MATRIC "
cquery += CRLF+"      AND BXQ2.BXQ_TIPREG = BA12.BA1_TIPREG "
cquery += CRLF+"      AND BXQ2.BXQ_REFERE = BXQ2.BXQ_PAGCOM "
cquery += CRLF+"      AND BXQ2.BXQ_PERCOM > 10 "
cquery += CRLF+"      AND BXQ2.BXQ_BASCOM > 0  "

cquery += CRLF+"    ORDER BY 10 ,1 "       

If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif                                             
  
TCQuery cQuery New Alias(cAliastmp)  
    
dbSelectArea(cAliastmp)                            

(cAliastmp)->(dbGoTop())     
titulo         := "Listagem Sintetica - Usuários que participaram da CABERJ e da INTEGRAL "
Cabec1         := "Org  Matritulas             Usuarios        Dt Incl   Dt Bloq    Cpf         Bas.Com    %   Agenc         Dest Matritulas          Usuarios        Dt Incl    Dt Bloq    Cpf         Bas.Com    %   Agenc  "
cabec2         := ' ' 
  
   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      nLin:=Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)  
      nLin++ 
   Endif                

While (cAliasTMP)->(!Eof())       
      
   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      nLin:=Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)  
      nLin++ 
   Endif                
    @ nLin, 000 Psay 'Cab'
	@ nLin, 005 Psay substr((cAliasTMP)->MAT_ANT,1,21) 
    @ nLin, 028 Psay substr((cAliasTMP)->NOME_ANT  ,1,15)   
	@ nLin, 044 Psay (cAliasTMP)->INC_ANT
	@ nLin, 054 Psay (cAliasTMP)->BLOQ_ANT 
    @ nLin, 065 Psay (cAliasTMP)->CPFANT                                   
    @ nLin, 077 Psay (Transform((cAliasTMP)->bascom1,"@E 99,999.99"))    
    @ nLin, 087 Psay (Transform((cAliasTMP)->percom1,"@E 999"))+'%' 
    @ nLin, 092 Psay (Transform((cAliasTMP)->vlrcom1,"@E 99,999.99")) 
    @ nLin, 102 Psay ' -> '    
    @ nLin, 106 Psay 'Int'
	@ nLin, 111 Psay substr((cAliasTMP)->MAT_ATU,1,21) 
    @ nLin, 133 Psay substr((cAliasTMP)->NOME_ATU,1,15)    
	@ nLin, 149 Psay (cAliasTMP)->INC_ATU
	@ nLin, 160 Psay (cAliasTMP)->BLOQ_ATU 
    @ nLin, 171 Psay (cAliasTMP)->CpfATU                                 
    @ nLin, 183 Psay (Transform((cAliasTMP)->bascom2,"@E 99,999.99"))    
    @ nLin, 193 Psay (Transform((cAliasTMP)->percom2,"@E 999"))+'%' 
    @ nLin, 198 Psay (Transform((cAliasTMP)->vlrcom2,"@E 99,999.99"))        
      nLin++            
            
     (cAliastmp)->(dbSkip())
     
enddo   
/*      
(cAliastmp)->(dbGoTop())        

titulo         := "Listagem Analitica - Usuários Bloquedos a menos de 180 dias com nova inclusão "
Cabec1         := "           Matritulas  Bloq      Usuarios             Dt Incl   Dt Bloq   Cpf          MatVida     Vlr Mensal  %     Vlr Comissao    Compt Dias   Vendedor"

Cabec2         := "           Matritulas  Ativ      Usuarios             Dt Incl   Dt Bloq   Cpf          MatVida     Vlr Mensal  %     Vlr Comissao    Compt        Vendedor                 %     Vlr Com Devido  Ajuste a Fazer   Parc "    

nLin := 80

While (cAliasTMP)->(!Eof())       

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      nLin:=Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)  
      nLin++  
   Endif                
   
   MovAnt( (cAliasTmp)->CEMPANT ,(cAliasTmp)->MATCANT ,(cAliasTmp)->TPRGANT )  
   
   MovAtu( (cAliasTmp)->CEMPATU ,(cAliasTmp)->MATCATU ,(cAliasTmp)->TPRGATU , (cAliasTmp)->CEMPANT)    
                                                
   MovAjt( (cAliasTmp)->CEMPATU ,(cAliasTmp)->MATCATU ,(cAliasTmp)->TPRGATU , (cAliasTmp)->CEMPANT ) 
       
   if (cAliasAnt)->(!Eof()) .and. (cAliasAtu)->(!Eof()) 
      lfaz:=.T.
   EndIf           
   While (  ((cAliasAnt)->(!Eof()) .or. (cAliasAtu)->(!Eof()) .or.  (cAliasAjt)->(!Eof())) .and. lFaz )       
                    
   If  cMatVid1    == ' ' 
       cMatvid1   :=  (cAliastmp)->MATVIDANT       
   ElseIf cMatvid1  !=  (cAliastmp)->MATVIDANT       
       cMatvid1     :=  (cAliastmp)->MATVIDANT

       @ nLin, 000 Psay      ctraco     
       
       nLin++                      
     @ nLin, 178 Psay (Transform(nvlrccert,"@E 999,999,999.99"))     
     @ nLin, 194 Psay (Transform(ndifdev  ,"@E 999,999,999.99"))    
       nLin++                                                        
     @ nLin, 000 Psay      ctraco                                   
       nvlrccertt+= nvlrccert     
       ndifdevt  += ndifdev
     
       nvlrccert:= 0.00     
       ndifdev  := 0.00 
       nLin++   
   EndIf                 
            

If (cAliasAnt)->(!Eof())

    @ nLin, 000 Psay 'Origem'
	@ nLin, 010 Psay substr((cAliasAnt)->MAT_ANT,1,21) 
    @ nLin, 033 Psay (cAliasAnt)->NOME_ANT    
	@ nLin, 055 Psay (cAliasAnt)->INC_ANT
	@ nLin, 065 Psay (cAliasAnt)->BLOQ_ANT 
    @ nLin, 075 Psay (cAliasAnt)->CPFANT 
    @ nLin, 088 Psay (cAliasAnt)->matvdANT                                 
	@ nLin, 096 Psay (Transform((cAliasAnt)->BSCOMANT,"@E 999,999,999.99"))   
	@ nLin, 112 Psay (cAliasAnt)->percANT                                             
	@ nLin, 115 Psay (Transform((cAliasAnt)->vlcomANT,"@E 999,999,999.99"))    	
	@ nLin, 134 Psay (cAliasAnt)->compANT   
	@ nLin, 142 Psay (cAliasTMP)->dias            
	@ nLin, 147 Psay (cAliasAnt)->codvenAnt + ' - ' +substr((cAliasAnt)->nomvenAnt,1,15)

	@ nLin, 212 Psay (cAliasAnt)->NUMPARANT
 
      nLin++   
     (cAliasAnt)->(dbSkip())
     
EndIf                   

If (cAliasAtu)->(!Eof()) 	

	@ nLin, 000 Psay 'Destino' 	  	     
	@ nLin, 010 Psay substr((cAliasATU)->MAT_ATU,1,21) 	  
    @ nLin, 033 Psay (cAliasATU)->NOME_ATU    
	@ nLin, 055 Psay (cAliasATU)->INC_ATU
	@ nLin, 065 Psay (cAliasATU)->BLOQ_ATU 
    @ nLin, 075 Psay (cAliasATU)->CPFATU
    @ nLin, 088 Psay (cAliasATU)->matvdATU                                 
	@ nLin, 096 Psay (Transform((cAliasATU)->bscomatu,"@E 999,999,999.99"))     
	@ nLin, 112 Psay (cAliasATU)->percatu                                             
	@ nLin, 115 Psay (Transform((cAliasATU)->vlcomatu,"@E 999,999,999.99"))    	
	@ nLin, 134 Psay (cAliasATU)->compatu
    
	@ nLin, 147 Psay (cAliasATU)->codvenATU + ' - ' +substr((cAliasATU)->nomvenATU,1,15)


	@ nLin, 172 Psay (cAliasATU)->percomATU            
   	@ nLin, 178 Psay (Transform((cAliasATU)->VlrccertATU,"@E 999,999,999.99"))     
   	@ nLin, 194 Psay (Transform((cAliasATU)->difdevATU,"@E 999,999,999.99"))    
 	@ nLin, 212 Psay (cAliasATU)->numparatu      
 	
 nvlrccert+=(cAliasATU)->VlrccertATU  
 ndifdev += (cAliasATU)->difdevATU    
   
      nLin++    

      (cAliasAtu)->(dbSkip())

EndIf 
   
If (cAliasAjt)->(!Eof()) 

    	@ nLin, 000 Psay 'Ajuste'
	  	@ nLin, 010 Psay substr((cAliasAjt)->MAT_RET,1,21) 	  
	    @ nLin, 033 Psay (cAliasAjt)->NOME_RET    
		@ nLin, 055 Psay (cAliasAjt)->INC_RET
		@ nLin, 065 Psay (cAliasAjt)->BLOQ_RET 
	    @ nLin, 075 Psay (cAliasAjt)->CPFRET 
	    @ nLin, 088 Psay (cAliasAjt)->matvdRET                                 
		@ nLin, 096 Psay (Transform((cAliasAjt)->bscomRET,"@E 999,999,999.99"))     
		@ nLin, 111 Psay (cAliasAjt)->percRET                                             
		@ nLin, 115 Psay (Transform((cAliasAjt)->vlcomRET,"@E 999,999,999.99"))    	
		@ nLin, 134 Psay (cAliasAjt)->compRET                
		@ nLin, 147 Psay ">> Ajuste Realizado <<" 
	
    	@ nLin, 171 Psay (cAliasAjt)->percRET                                
	   
    	@ nLin, 194 Psay (Transform((cAliasAjt)->vlcomRET,"@E 999,999,999.99"))    
          
		@ nLin, 212 Psay (cAliasAjt)->numparRET       
	      nLin++                         
          ndifdev  += (cAliasAjt)->vlcomRET  
          (cAliasAjt)->(dbSkip()) 
  EndIf 

EndDo                   
      (cAliastmp)->(dbSkip())     
      lFaz := .F.
EndDo   
                           
 @ nLin, 000 Psay      ctraco     
       
   nLin++                      
 @ nLin, 178 Psay (Transform(nvlrccert,"@E 999,999,999.99"))     
 @ nLin, 194 Psay (Transform(ndifdev  ,"@E 999,999,999.99"))    
   nLin++                                                        
 
   nvlrccertt+= nvlrccert     
   ndifdevt  += ndifdev
      

 @ nLin, 000 Psay      ctraco   
   nLin++    
 @ nLin, 178 Psay (Transform(nvlrccertt,"@E 999,999,999.99"))     
 @ nLin, 194 Psay (Transform(ndifdevt  ,"@E 999,999,999.99"))    
  nLin++

 @ nLin, 000 Psay      ctraco    

If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
If Select((cAliasANT)) <> 0 
  (cAliasANT)->(DbCloseArea()) 
Endif
If Select((cAliasATU)) <> 0 
  (cAliasATU)->(DbCloseArea()) 
Endif
If Select((cAliasAjt)) <> 0 
  (cAliasAjt)->(DbCloseArea()) 
Endif 

    nLin++                                                        
    
	@ nLin, 000 Psay      ctraco   
	nLin++    
	@ nLin, 000 Psay "CONSIDERAÇÕES PARA ESTE RELATÓRIO "
	nLin++    
	@ nLin, 000 Psay "	È considerado agenciamento qualquer comissão maior que 10% em qualquer parcela de pagamento.                "  
	nLin++    
    @ nLin, 000 Psay "	Quando houver pagamento de agenciamento na primeira matrícula e na segunda matrícula  , deve-se calcular a  "
	nLin++
    @ nLin, 000 Psay "	  comissão devida ,  e deduzir o valor calculado como agenciamento  > O resultado deve ser lançado a débito na comissão." 
	nLin++    
    @ nLin, 000 Psay "	Quando não hover pagamento de agenciamento na primeira matrícula , na segunda , o agenciamento sera devido , se houver.   "
	nLin++                          
    @ nLin, 000 Psay "	na coluna origem sera escrito MV - quando a extração for por matricula da vida iguais ou  "
	nLin++
    @ nLin, 000 Psay "	na coluna origem sera escrito CDN - quando a extração for por CPF e Data de Nascimento iguais "
	nLin++
	@ nLin, 000 Psay      ctraco    
	 	 
////

*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

STATIC FUNCTION MovAnt( cEmpAnt , cMatAnt , cTpRegAnt ) 
/*
-----------
---COMISSAO ANTERIOR 
-----------
*/
cquery1 := CRLF+"     SELECT  DISTINCT BA11.BA1_CODEMP , BA11.BA1_MATVID ,
cquery1 += CRLF+"             SIGA.FORMATA_MATRICULA_MS( TRIM(BA11.BA1_CODINT)||TRIM(BA11.BA1_CODEMP)||TRIM(BA11.BA1_MATRIC)||TRIM(BA11.BA1_TIPREG)||TRIM(BA11.BA1_DIGITO)) MAT_ANT , 
cquery1 += CRLF+"             SUBSTR(BA11.BA1_NOMUSR,1,20) NOME_ANT , 
cquery1 += CRLF+"             TO_DATE( BA11.BA1_DATINC, 'YYYYMMDD') INC_ANT , 
cquery1 += CRLF+"             TO_DATE(TRIM(BA11.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ANT , 
cquery1 += CRLF+"             BA11.BA1_CPFUSR CPFANT , 
cquery1 += CRLF+"             BA11.BA1_MATVID MATVDANT , 
cquery1 += CRLF+"             BXQ1.BXQ_BASCOM BSCOMANT , 
cquery1 += CRLF+"             BXQ1.BXQ_PERCOM PERCANT , 
cquery1 += CRLF+"             BXQ1.BXQ_VLRCOM VLCOMANT , 
cquery1 += CRLF+"             BXQ1.BXQ_ANO||'/'||BXQ1.BXQ_MES  COMPANT , 
cquery1 += CRLF+"             BXQ1.BXQ_NUMPAR NUMPARANT ,
cquery1 += CRLF+"             BXQ1.BXQ_CODVEN CODVENANT ,
cquery1 += CRLF+"             sa3.A3_NOME NOMVENant " 

cquery1 += CRLF+"     FROM "+ RetSqlName("BA1") + " BA11 ,"+ RetSqlName("BXQ") + " BXQ1 ,"+ RetSqlName("SA3") + " SA3 "  

cquery1 += CRLF+"    WHERE BA11.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA11.D_e_l_e_t_ = ' ' "
cquery1 += CRLF+"      AND BXQ1.BXQ_FILIAL  = '" + xFilial('BXQ') + "' AND BXQ1.D_e_l_e_t_ = ' ' "  
 
cquery1 += CRLF+"      AND SA3.A3_FILIAL    = '" + xFilial('SA3') + "' AND SA3.D_e_l_e_t_  = ' ' "
        
cquery1 += CRLF+"      AND BXQ1.BXQ_CODEMP = '"+cEmpAnt+"'"   
cquery1 += CRLF+"      AND BXQ1.BXQ_MATRIC = '"+cMatAnt+"'"
cquery1 += CRLF+"      AND BXQ1.BXQ_TIPREG = '"+cTpRegAnt+"'"
      
cquery1 += CRLF+"      AND BA11.BA1_CODEMP = BXQ1.BXQ_CODEMP "  
cquery1 += CRLF+"      AND BA11.BA1_MATRIC = BXQ1.BXQ_MATRIC "
cquery1 += CRLF+"      AND BA11.BA1_TIPREG = BXQ1.BXQ_TIPREG " 


   cquery1 += CRLF+"      AND BXQ1.BXQ_REFERE = BXQ1.BXQ_PAGCOM " 
   cquery1 += CRLF+"      AND BXQ1.BXQ_PERCOM > 10 "
   cquery1 += CRLF+"      AND BXQ1.BXQ_BASCOM > 0  " 
          

cquery1 += CRLF+"      AND BXQ1.BXQ_CODVEN = A3_COD "
If mv_par05 == 1
   cquery1 += CRLF+"    ORDER BY BA11.BA1_MATVID , bxq1.bxq_codven ,BXQ1.BXQ_NUMPAR  " 
Else
   cquery1 += CRLF+"    ORDER BY SIGA.FORMATA_MATRICULA_MS( TRIM(BA11.BA1_CODINT)||TRIM(BA11.BA1_CODEMP)||TRIM(BA11.BA1_MATRIC)||TRIM(BA11.BA1_TIPREG)||TRIM(BA11.BA1_DIGITO)) , bxq1.bxq_codven ,BXQ1.BXQ_NUMPAR  " 
EndIf   
//------        

If Select((cAliasANT)) <> 0 
  (cAliasANT)->(DbCloseArea()) 
Endif
  
TCQuery cQuery1 New Alias(cAliasANT)  
    
dbSelectArea(cAliasANT)
   
(cAliasANT)->(dbGoTop())   
     

 RETURN   
 
STATIC FUNCTION MovAtu( cEmpAtu , cMatAtu , cTpRegAtu , cEmpAnt) 

/*
-----------
---COMISSAO Atual 
-----------
*/    

cquery2 := CRLF+"        select  distinct BA12.BA1_CODEMP , ba12.ba1_matvid ,
cquery2 += CRLF+"                SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO)) MAT_ATU , 
cquery2 += CRLF+"                SUBSTR(BA12.BA1_NOMUSR,1,20) NOME_ATU , 
cquery2 += CRLF+"                TO_DATE( BA12.BA1_DATINC, 'YYYYMMDD') INC_ATU , 
cquery2 += CRLF+"                TO_DATE(TRIM(BA12.BA1_DATBLO) , 'YYYYMMDD')BLOQ_ATU , 
cquery2 += CRLF+"                BA12.BA1_CPFUSR CPFATU , 
cquery2 += CRLF+"                BA12.BA1_MATVID MATVDATU , 
cquery2 += CRLF+"                BXQ2.BXQ_BASCOM BSCOMATU , 
cquery2 += CRLF+"                BXQ2.BXQ_PERCOM PERCATU, 
cquery2 += CRLF+"                BXQ2.BXQ_VLRCOM VLCOMATU , 
cquery2 += CRLF+"                BXQ2.BXQ_ANO ||'/'||BXQ2.BXQ_MES  COMPATU , 
cquery2 += CRLF+"                BXQ2.BXQ_NUMPAR NUMPARATU ,
cquery2 += CRLF+"                BXQ2.BXQ_CODVEN CODVENATU ,           
                                                               
cquery2 += CRLF+"                bxj_codven codvenATU ,a3_nome nomvenATU ,    nvl(bxk_percon,BXQ2.BXQ_PERCOM) percomATU , 
cquery2 += CRLF+"               (BXQ2.bxq_bascom * nvl(bxk_percon,0) /100) VlrCCertATU   , 
cquery2 += CRLF+"                BXQ2.bxq_vlrcom - (BXQ2.bxq_bascom * nvl(bxk_percon,0) /100) difdevATU   

cquery2 += CRLF+"     FROM "+ RetSqlName("BA1") + " BA12 ,"+ RetSqlName("BXQ") + " BXQ2 , "  
cquery2 += CRLF+"          "+ RetSqlName("BXJ") + " BXJ  ,"+ RetSqlName("SA3") + " SA3  ,"+ RetSqlName("BXK") + " BXK "        

cquery2 += CRLF+"    WHERE BA12.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA12.D_e_l_e_t_ = ' ' "
cquery2 += CRLF+"      AND BXQ2.BXQ_FILIAL  = '" + xFilial('BXQ') + "' AND BXQ2.D_e_l_e_t_ = ' ' "  
cquery2 += CRLF+"      AND BXJ.BXJ_FILIAL   = '" + xFilial('BXJ') + "' AND BXJ.D_e_l_e_t_  = ' ' "
cquery2 += CRLF+"      AND SA3.A3_FILIAL    = '" + xFilial('SA3') + "' AND SA3.D_e_l_e_t_  = ' ' "
cquery2 += CRLF+"      AND BXK.BXK_FILIAL(+)   = '" + xFilial('BXK') + "' AND BXK.D_e_l_e_t_(+)  = ' ' "
        
cquery2 += CRLF+"      AND BXQ2.BXQ_CODEMP = '"+cEmpAtu+"'"   
cquery2 += CRLF+"      AND BXQ2.BXQ_MATRIC = '"+cMatAtu+"'"
cquery2 += CRLF+"      AND BXQ2.BXQ_TIPREG = '"+cTpRegAtu+"'"

     
   cquery2 += CRLF+"   AND BXQ2.BXQ_REFERE = BXQ2.BXQ_PAGCOM "
   cquery2 += CRLF+"   AND BXQ2.BXQ_PERCOM > 10 "
   cquery2 += CRLF+"   AND BXQ2.BXQ_BASCOM > 0 " 

cquery2 += CRLF+"      AND BA12.BA1_CODEMP = BXQ2.BXQ_CODEMP "  
cquery2 += CRLF+"      AND BA12.BA1_MATRIC = BXQ2.BXQ_MATRIC "
cquery2 += CRLF+"      AND BA12.BA1_TIPREG = BXQ2.BXQ_TIPREG "

cquery2 += CRLF+"      and bxj_vldfim = ' ' " 
cquery2 += CRLF+"      AND bxj_codemp = BXQ2.BXQ_codemp " 
cquery2 += CRLF+"      and bxj_codven = bxq2.bxq_codven "
cquery2 += CRLF+"      AND bxk_seqbxj(+) = bxj_seq "
cquery2 += CRLF+"      AND bxj_codven = a3_cod AND bxj_vldfim = ' ' "
cquery2 += CRLF+"      AND bxk_percon(+) <= 10 "         
If mv_par05 == 1
   cquery2 += CRLF+"    ORDER BY  BA12.BA1_MATVID , bxq2.bxq_codven , BXQ2.BXQ_NUMPAR "
Else
   cquery2 += CRLF+"    ORDER BY  SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO)), bxq2.bxq_codven , BXQ2.BXQ_NUMPAR "
EndIf 
//------        

If Select((cAliasATU)) <> 0 
  (cAliasATU)->(DbCloseArea()) 
Endif
  
TCQuery cQuery2 New Alias(cAliasATU)  
    
dbSelectArea(cAliasATU)
   
(cAliasATU)->(dbGoTop())   
     
RETURN() 

STATIC FUNCTION MovAjt( cEmpAjt , cMatAjt , cTpRegAjt , cEmpAnt ) 
/*     
-----------
---COMISSAO ajuste  
-----------
*/  
cquery3 := CRLF+"   select distinct BA12.BA1_CODEMP , ba12.ba1_matvid , "
cquery3 += CRLF+"          SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO)) MAT_RET , "
cquery3 += CRLF+"          SUBSTR(BA12.BA1_NOMUSR,1,20) NOME_RET , " 
cquery3 += CRLF+"          TO_DATE( BA12.BA1_DATINC, 'YYYYMMDD') INC_RET , "
cquery3 += CRLF+"          TO_DATE(TRIM(BA12.BA1_DATBLO) , 'YYYYMMDD')BLOQ_RET , "
cquery3 += CRLF+"          BA12.BA1_CPFUSR CPFRET ,   "
cquery3 += CRLF+"          BA12.BA1_MATVID MATVDRET , "
cquery3 += CRLF+"          BXQ3.BXQ_BASCOM BSCOMRET , "
cquery3 += CRLF+"          BXQ3.BXQ_PERCOM PERCRET,   "
cquery3 += CRLF+"          BXQ3.BXQ_VLRCOM VLCOMRET , "
cquery3 += CRLF+"          BXQ3.BXQ_ANO||'/'||BXQ3.BXQ_MES  COMPRET , "
cquery3 += CRLF+"          BXQ3.BXQ_NUMPAR NUMPARRET , "
cquery3 += CRLF+"          BXQ3.BXQ_CODVEN CODVENRET , "
cquery3 += CRLF+"          bxj_codven codvenRET ,a3_nome nomvenRET ,  bxk_percon percomRET "          

cquery3 += CRLF+"     FROM "+ RetSqlName("BA1") + " BA12 ,"+ RetSqlName("BXQ") + " BXQ3 , "  
cquery3 += CRLF+"          "+ RetSqlName("BXJ") + " BXJ  ,"+ RetSqlName("SA3") + " SA3  ,"+ RetSqlName("BXK") + " BXK "        

cquery3 += CRLF+"    WHERE BA12.BA1_FILIAL  = '" + xFilial('BA1') + "' AND BA12.D_e_l_e_t_ = ' ' "
cquery3 += CRLF+"      AND BXQ3.BXQ_FILIAL  = '" + xFilial('BXQ') + "' AND BXQ3.D_e_l_e_t_ = ' ' "  
cquery3 += CRLF+"      AND BXJ.BXJ_FILIAL   = '" + xFilial('BXJ') + "' AND BXJ.D_e_l_e_t_  = ' ' "
cquery3 += CRLF+"      AND SA3.A3_FILIAL    = '" + xFilial('SA3') + "' AND SA3.D_e_l_e_t_  = ' ' "
cquery3 += CRLF+"      AND BXK.BXK_FILIAL   = '" + xFilial('BXK') + "' AND BXK.D_e_l_e_t_  = ' ' "
        
cquery3 += CRLF+"      AND BXQ3.BXQ_CODEMP = '"+cEmpAjt+"'"   
cquery3 += CRLF+"      AND BXQ3.BXQ_MATRIC = '"+cMatAjt+"'"
cquery3 += CRLF+"      AND BXQ3.BXQ_TIPREG = '"+cTpRegAjt+"'" 

cquery3 += CRLF+"      AND BXQ3.BXQ_REFERE = BXQ3.BXQ_PAGCOM "
cquery3 += CRLF+"      AND BXQ3.BXQ_BASCOM < 0    "
cquery3 += CRLF+"      AND BXQ3.BXQ_NUMPAR >= 999  "
      
cquery3 += CRLF+"      AND BA12.BA1_CODEMP = BXQ3.BXQ_CODEMP "  
cquery3 += CRLF+"      AND BA12.BA1_MATRIC = BXQ3.BXQ_MATRIC "
cquery3 += CRLF+"      AND BA12.BA1_TIPREG = BXQ3.BXQ_TIPREG "

cquery3 += CRLF+"      and bxj_codven = bxq3.bxq_codven "
cquery3 += CRLF+"      and bxj_vldfim = ' ' "
cquery3 += CRLF+"      AND bxj_codemp = BXQ3.BXQ_codemp "                                    
cquery3 += CRLF+"      AND bxk_seqbxj = bxj_seq "
cquery3 += CRLF+"      AND bxj_codven = a3_cod AND bxj_vldfim = ' ' "
cquery3 += CRLF+"      AND bxk_percon <= 10     "                
If mv_par05 == 1
   cquery3 += CRLF+"    ORDER BY BA12.BA1_MATVID , bxq3.bxq_codven ,  BXQ3.BXQ_NUMPAR  "
Else                                                                                    
   cquery3 += CRLF+"    ORDER BY SIGA.FORMATA_MATRICULA_MS( TRIM(BA12.BA1_CODINT)||TRIM(BA12.BA1_CODEMP)||TRIM(BA12.BA1_MATRIC)||TRIM(BA12.BA1_TIPREG)||TRIM(BA12.BA1_DIGITO))  , bxq3.bxq_codven ,  BXQ3.BXQ_NUMPAR  "
EndIf   

//------        

If Select((cAliasAjt)) <> 0 
  (cAliasAjt)->(DbCloseArea()) 
Endif
  
TCQuery cQuery3 New Alias(cAliasAjt)  
    
dbSelectArea(cAliasAjt)
   
(cAliasAjt)->(dbGoTop())   
     

 RETURN   

Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
                      
PutSx1(cPerg,"01",OemToAnsi("Empresa Inicio    ?  ") 		,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","999999",aHelpPor,{},{}) 
PutSx1(cPerg,"02",OemToAnsi("Empresa Final     ?  ") 		,"","","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","999999",aHelpPor,{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Competencia Inicial ?") 		,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","999999",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Competencia Final   ?") 		,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","999999",aHelpPor,{},{})
PutSx1(cPerg,"05",OemToAnsi("Ordenar Por          ")     	,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Matvida ","","","","Matricula ","",""," ","","","","","","","","",{},{},{})   
//PutSx1(cPerg,"03",OemToAnsi("Reprocessar     ?  ")     	,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim ","","","","Não ","",""," ","","","","","","","","",{},{},{})   
//PutSx1(cPerg,"04",OemToAnsi("Matr. Completa     ") 		,"","","mv_ch4","C",17,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return          
