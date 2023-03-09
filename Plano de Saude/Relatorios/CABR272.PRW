#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"
                                              
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR245   º Autor ³Altamiro              º Data ³ 24/10/17  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Acompanhamento do Sib - extrato               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                                                      

User Function CABR272( )

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR272"
Private cTitulo     := "Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel "        
private aDados1     := {} 
private aDados2     := {}
Private cAliastmp 	:= GetNextAlias()             
private faz         := 1

cMsg += " Este programa ira Gerar Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel  " + CRLF
cMsg += "  " + CRLF

***************************************************************************    
 
Private  acabec1:={"Tp Ação",;
                   "Mat Trasf Orig",;
                   "Mat Trasf Dest",;
                   "Cod Cco",;
                   "Cpf",;
                   "Nome Usuario",;
                   "Matricula",;
                   "Dt Inic",;
                   "Dt Bloq",;
                   "Motivo Bloq",;
                   "Nivel Bloq",;
                   "Locsib",;
                   "Atual Sib",;
                   "Informe Sib",;
                   "Informa Ans",;
                   "Bloq",;
                   "Inf. Bloq Ans",;
                   "Motivo Bloq" ,;
                   "CodEmp" ,;
                   "Recno"} 

private  Descric := ' '                                                                                                         

  // AjustaSX1(cPerg)

   Pergunte(cPerg,.T.)

 //  cDtEntr    := dtos(mv_par01)     
 //  cdata      := substr(cDtEntr,7,2)+'/'+substr(cDtEntr,5,2)+'/'+substr(cDtEntr,1,4)
   cEmpresa   :=Iif(cEmpAnt == '01', 'Caberj', 'Integral')                   
   
   Processa({||Processa1()}, cTitulo, "", .T.)
   


//lexcel	   := .T.    
  
//Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
  
// faz ecxel

// if lexcel      
         
   DlgToExcel({{"ARRAY","Extrato de Ações Sibão " ,aCabec1,aDados1}})   

// EndIF

fGeraRel2()    

MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Processa1() 

Local cquery := ''       

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
///////////////////////////////////

for Faz := 1 to 2

 If Faz == 1
	cQuery := CRLF+ " Select "   
 Else 	
    cQuery += CRLF+ " Select "   
 EndIf    
	cQuery += CRLF+ " case when (ba1_datblo >= '"+dtos(mv_par03)+"'  and ba1_datblo <= '"+dtos(mv_par04)+"' and ba1_codcco <> ' ' ) then '2 - Bloq' "
	cQuery += CRLF+ "      when (ba1_datinc >= '"+dtos(mv_par01)+"'  and ba1_datinc <= '"+dtos(mv_par02)+"' and ba1_codcco = ' '  ) then '1 - Incl' "
	cQuery += CRLF+ " else  ' ' End  acao , "
	cQuery += CRLF+ " Ba1.Ba1_Traori,Ba1.Ba1_Trades, "                                                            
	cQuery += CRLF+ " Ba1_Codcco Codcco , Ba1_Cpfusr Cpf,Ba1_Nomusr Nomusr, " 
	cQuery += CRLF+ " Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito Matric , "   
	cQuery += CRLF+ " substr(Ba1_Datinc,7,2)||'/'||substr(Ba1_Datinc,5,2)||'/'||substr(Ba1_Datinc,1,4) Datinc , "  
	cQuery += CRLF+ " substr(Ba1_Datblo,7,2)||'/'||substr(Ba1_Datblo,5,2)||'/'||substr(Ba1_Datblo,1,4) DatBlo , " 
	cQuery += CRLF+ " Ba1.Ba1_Motblo Motblo ," //"decode(Ba1_Consid,'U','Usuario', 'F', 'Familia', 'S', 'Sub Cont', ' ')  NivBloq, "          
	
	cQuery += CRLF+ " decode (trim(Ba1.Ba1_Motblo) ,  null , ' ' , (decode(Ba1_Consid,'U','Usuario', 'F', 'Familia', 'S', 'Sub Cont', ' ')))  NivBloq,

	cQuery += CRLF+ " decode(BA1_LOCSIB,'0','0-HA ENVIAR', "
	cQuery += CRLF+ " '1','1-ATIVO', "
	cQuery += CRLF+ " '2','2-EXCLUIDO' , "  
	cQuery += CRLF+ " '3','3-ENVIADO INCLUSAO' ," 
	cQuery += CRLF+ " '4','4-ENVIADO ALTERACAO' ,"
	cQuery += CRLF+ " '5','5-ENVIADO EXCLUSAO' ,"  
	cQuery += CRLF+ " '6','6-FORCAR INCLUSAO' ,"
	cQuery += CRLF+ " '7','7-FORCAR ALTERACAO'," 
	cQuery += CRLF+ " '8','8-FORCAR EXCLUSAO'," 
	cQuery += CRLF+ " '9','9-MUDANCA CONTRATUAL',"
	cQuery += CRLF+ " 'A','A-REATIVACAO',"
	cQuery += CRLF+ " 'B','B-FORCAR MUD. CONTR.', "
	cQuery += CRLF+ " 'C','C-FORCAR REATIVACAO') LocSib , "  
	cQuery += CRLF+ " decode(BA1_ATUSIB,'0','Não','Sim') AtuSib ,"
	cQuery += CRLF+ " decode(BA1_INFSIB,'0','Não','Sim') InfSib ,"
	cQuery += CRLF+ " decode(BA1_INFANS,'0','Não','Sim') InfAns ,"     
	/*
	cQuery += CRLF+ " Decode(Trim(Ba1_Motblo),'', 'sem Bloq',(Decode(Trim(Case When Ba1_Consid = 'U' Then Nvl(Blqu.Descri, ' ' ) "   
	cQuery += CRLF+ " When Ba1_Consid = 'F' Then Nvl(Blqf.Descri, ' ' ) "    
	cQuery += CRLF+ " When Ba1_Consid = 'S' Then Nvl(Blqs.Descri, ' ' ) "  
	cQuery += CRLF+ " Else 'S/Descriçao' End),Null,'Bloq Temp','Bloq Def'))) Bloq_Ans ,"
	*/
	cQuery += CRLF+ " Decode(Trim(Ba1_Motblo),'', 'sem Bloq',("
	cQuery += CRLF+ " decode(trim(Case When Ba1_Consid = 'U' Then Nvl(Blqu.Blqans, '' )" 
    cQuery += CRLF+ " When Ba1_Consid = 'F' Then Nvl(Blqf.Blqans, '' ) "
    cQuery += CRLF+ " When Ba1_Consid = 'S' Then Nvl(Blqs.Blqans, '' ) "
    cQuery += CRLF+ " Else 'S/Descriçao' End), '', 'Bloq_Temp', 'Bloq Def'))) Bloq_Ans , "
	
	
	cQuery += CRLF+ " Case When Ba1_Consid = 'U' Then Nvl(Blqu.Blqans, ' ' ) "  
	cQuery += CRLF+ "      When Ba1_Consid = 'F' Then Nvl(Blqf.Blqans, ' ' ) "    
	cQuery += CRLF+ "      When Ba1_Consid = 'S' Then Nvl(Blqs.Blqans, ' ' ) "  
	cQuery += CRLF+ " Else 'S/Descriçao' End  inf_Ans , ba1_motblo , ba1.R_E_C_N_O_ num_recno"
	
	cQuery += CRLF+ " From "+ RetSqlName("BA1") +" BA1 , "
	cQuery += CRLF+ " ( Select 'usuario' Origem  , Bg3_Codblo Codblo , Bg3_Desblo Descri , Bg3_Blqans  Blqans  From "+ RetSqlName("BG3") +" BG3  Where Bg3_Filial= '"+xFilial('BG3')+ "' And Bg3.D_E_L_E_T_ = ' ') Blqu , "
	cQuery += CRLF+ " ( Select 'familia' Origem  , Bg1_Codblo Codblo , Bg1_Desblo Descri , Bg1_Blqans  Blqans  From "+ RetSqlName("BG1") +" BG1  Where Bg1_Filial= '"+xFilial('BG1')+ "' And Bg1.D_E_L_E_T_ = ' ') Blqf , " 
    cQuery += CRLF+ " ( Select 'sub_cont' Origem , Bqu_Codblo Codblo , Bqu_Desblo Descri , Bqu_Blqans  Blqans  From "+ RetSqlName("BQU") +" BQU  Where Bqu_Filial= '"+xFilial('BQU')+ "' And Bqu.D_E_L_E_T_ = ' ') Blqs   "
					
	cQuery += CRLF+ " Where  Ba1_Filial = '"+xFilial('BA1')+ "'   And BA1.D_E_L_E_T_ = ' ' "       
	cQuery += CRLF+ " And Ba1_Codint||Ba1_Codemp||Ba1_Matric||Ba1_Tipreg||Ba1_Digito in  "
	cQuery += CRLF+ " ( select Ba1_CODINT || Ba1_CODEMP || Ba1_MATRIC || Ba1_TIPREG || Ba1_DIGITO "
	cQuery += CRLF+ "     from "+ RetSqlName("BA1") +" BA1  " 
	
	If Faz == 1
	   if cEmpAnt == '01'
	      cQuery += CRLF+ "        , confsib_cab SIB "
	   Else 
	      cQuery += CRLF+ "        , confsib_int SIB "
	   EndIf    
	EndIf   
	
	cQuery += CRLF+ "    where ba1_filial ='"+xFilial('BA1')+ "'   and d_E_L_E_T_ = ' ' "
	
	If Faz == 1
	   cQuery += CRLF+ "      and ba1_datblo >= '"+dtos(mv_par03)+"'  and ba1_datblo <= '"+dtos(mv_par04)+"' and ba1_codcco <> ' ' " 
	   cQuery += CRLF+ "      and Ba1_CODINT || Ba1_CODEMP || Ba1_MATRIC || Ba1_TIPREG || Ba1_DIGITO   = SIB_MATRIC "
	   cQuery += CRLF+ "      and SIB_SITUAC = '1'
	Else 
	   cQuery += CRLF+ "      and ba1_datinc >= '"+dtos(mv_par01)+"'  and ba1_datinc <= '"+Dtos(mv_par02)+"' and ba1_codcco = ' ' "
	EndIf 
	cQuery += CRLF+ " ) "
	if cEmpAnt == '01'
	   cQuery += CRLF+ "      And Ba1_codemp not in ('0004','0009') "  
	EndIf
	cQuery += CRLF+ "      And Ba1_Motblo = Blqu.Codblo(+) "  
	cQuery += CRLF+ "      And Ba1_Motblo = Blqf.Codblo(+) " 
	cQuery += CRLF+ "      And Ba1_Motblo = Blqs.Codblo(+) "
	
	If     mv_par05 == 1
	
	   cQuery += CRLF+ "      and ba1_atusib <> '0' and ba1_infsib <> '0' and ba1_infans <> '0'
	
	ElseIf mv_par05 == 2 
	
	   cQuery += CRLF+ "      and (ba1_atusib = '0' or ba1_infsib = '0' or ba1_infans = '0')
	
	EndIF 
	   
	if Faz == 1
	   cQuery += CRLF+ "Union All "
	Else 
	   cQuery += CRLF+ "      order by 1 "
	EndIf 
                
Next faz
                                              

////////////////////////////////////////       
	   	
    TCQuery cQuery New Alias (cAliastmp)
      
    dbSelectArea (cAliastmp)
   
    (cAliastmp)->(dbGoTop())   
     
    While (cAliastmp)->(!Eof())   
    
    
     
           aaDD(aDados1,{   (cAliastmp)->ACAO         ,;
							(cAliastmp)->BA1_TRAORI   ,;     
							(cAliastmp)->BA1_TRADES   ,;     
							(cAliastmp)->CODCCO       ,;
							(cAliastmp)->CPF          ,;
							(cAliastmp)->NOMUSR       ,;                                                          
							(cAliastmp)->MATRIC       ,;     
							(cAliastmp)->DATINC       ,;                                                                            
							(cAliastmp)->DATBLO       ,;                                                                            
							(cAliastmp)->MOTBLO       ,;
							(cAliastmp)->NIVBLOQ      ,;                    
							(cAliastmp)->LOCSIB       ,;                    
							(cAliastmp)->ATUSIB       ,;                    
							(cAliastmp)->INFSIB       ,;                    
							(cAliastmp)->INFANS       ,;                    
							(cAliastmp)->BLOQ_ANS     ,;                    
							(cAliastmp)->INF_ANS      ,;
							(cAliastmp)->BA1_MOTBLO   ,;
							(cAliastmp)->BA1_CODEMP   ,;
							(cAliastmp)->num_recno    })                                 
                  
       (cAliastmp)->(dbSkip()) 	   
    
    EndDo	                   
 
Return    

*************************************************************************************************************  
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR272"                                                           ¦

Private aOrdem 		:= {}//{'RDA','Ano/Mes'}            
Private lTPageBreak := .T.         


//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef2()

Local oReport 
Local oDPJ        
Local oDPJ1                
oReport	:= TReport():New("CABR272","Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel " + mv_par01  ,, {|oReport| ReportPrt(oReport)},"Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel - " + mv_par01 )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(3) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oReport:SetTotalPageBreak(lTPageBreak)

oDPJ := TRSection():New(oReport,"Relatorio de Acompanhamento de inclusoes e execlições do Sib - Excel" ,,aOrdem)              

   TRCell():New(oDPJ ,'TPACAO'	        	,	,'Acao    '       ,                 ,10	    	,,,,,"LEFT" )   
   TRCell():New(oDPJ ,'CODCCO'         		,	,'Cod Cco     '   ,                 ,12     	,,,,,"LEFT"	)  
   TRCell():New(oDPJ ,'CPF'         		,	,'Cpf        '    ,                 ,11     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'NOMUSR'         		,	,'Usuario '       ,                 ,30     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'MATRIC'         		,	,'Matricul'       ,                 ,17     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'DATINC'         		,	,'Dt Incl '       ,                 ,12     	,,,,,"LEFT"	)
   TRCell():New(oDPJ ,'DATBLO'         		,	,'Dt Bloq '       ,                 ,12     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'MOTBLO'         		,	,'Mot Bloq'       ,                 ,06     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'NIVBLO'         		,	,'Niv Bloq'       ,                 ,07     	,,,,,"LEFT"	)   
   TRCell():New(oDPJ ,'LOCSIB'         		,	,'LocSib  '       ,                 ,17     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'ATUSIB'         		,	,'Atu Sib '       ,                 ,07     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'INFSIB'         		,	,'Inf Sib '       ,                 ,07     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'INFANS'         		,	,'Inf Ans '       ,                 ,07     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'BLOANS'         		,	,'Bloq Ans'       ,                 ,10     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'CODANS'         		,	,'Cod Ans '       ,                 ,07     	,,,,,"LEFT"	) 
   TRCell():New(oDPJ ,'CODBLO'         		,	,'Cod Bloq'       ,                 ,07     	,,,,,"LEFT"	) 
   


lTotSecBrk	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado
                                                                   
  
  
**********************  
  
                                                                                                                         
Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrt(oReport)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local   cImp    :='Não'
Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados     
  oDPJ:init()
  nCont := Len(aDados1)
  
  oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

   For i := 1 To Len(aDados1)

    oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf          

 oDPJ:Cell('TPACAO'):SetValue((aDados1[i][ 1]))    
 oDPJ:Cell('CODCCO'):SetValue((aDados1[i][ 4]))     
 oDPJ:Cell('CPF'   ):SetValue((aDados1[i][ 5]))   
 oDPJ:Cell('NOMUSR'):SetValue((aDados1[i][ 6]))    
 oDPJ:Cell('MATRIC'):SetValue((aDados1[i][ 7]))    
 oDPJ:Cell('DATINC'):SetValue((aDados1[i][ 8]))   
 oDPJ:Cell('DATBLO'):SetValue((aDados1[i][ 9]))      
 oDPJ:Cell('MOTBLO'):SetValue((aDados1[i][10]))      
 oDPJ:Cell('NIVBLO'):SetValue((aDados1[i][11]))      
 oDPJ:Cell('LOCSIB'):SetValue((aDados1[i][12]))    
 oDPJ:Cell('ATUSIB'):SetValue((aDados1[i][13]))    
 oDPJ:Cell('INFSIB'):SetValue((aDados1[i][14]))    
 oDPJ:Cell('INFANS'):SetValue((aDados1[i][15]))    
 oDPJ:Cell('BLOANS'):SetValue((aDados1[i][16]))    
 oDPJ:Cell('CODANS'):SetValue((aDados1[i][17]))    
 oDPJ:Cell('CODBLO'):SetValue((aDados1[i][18]))    
      
       oDPJ:PrintLine()
   
   Next i

   oDPJ:Finish()      

*********************************************************************************


Return  
*********************************************************************************


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Data de Entrega ") 		      ,"","","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"02",OemToAnsi("Empresa         ")               ,"","","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Caberj","","","","Integral","","","Todas","","","","","","","","",{},{},{}) 
PutSx1(cPerg,"03",OemToAnsi("Elietos P/ Envio")               ,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","So Elitos","","","","Não Eleitos","","","Todas","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.F.)

Return

