#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FONT.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA330   บAutor  ณMarcela Coimbra     บ Data ณ  05/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Gera planilha com fator moderador                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออ'อออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿      
*/


User Function CABA330()       
	                               
	Local c_Perg := "CABA330"  

	PRIVATE lEnd := .F.  

	MenuDef(c_Perg)              
	
	If !Pergunte( c_Perg , .t.)
	     
		Return                 
	
	EndIf
	
   //	Processa({||Processa1()}, "Gerando planilha de Fator Moderador", "", .T.)
	MsAguarde({|lEnd| Processa1(@lEnd)},"Aguarde...","Processando Fator Moderador",.T.)
	
Return                 

Static Function Processa1( lEnd ) 

	Local c_Qry := ""
	Local a_Vet := {}
	Local a_Tit := {}  
	
	Local nOrdem                        // publica variavel 
	Private cDirDocs := MsDocPath()     // priva variavel com o caminho do arquivo temporario na rotina 
	Private cNomeArq := CriaTrab(,.F.) 
		
	c_Qry+= "	SELECT EMPRESA, FUNCION, TIT_DEP, MATRICU, CPF, NOME, PRESTAD, PROCEDI, QTD_PROC, VALOR, DATPRO, MESREF 
	c_Qry+= "	FROM ("
	c_Qry+= "	select  distinct bqc_cnpj EMPRESA, "
    c_Qry+= "           ba3_matemp FUNCION, "
    c_Qry+= "           ba1_tipusu TIT_DEP, "
    c_Qry+= "           ba1_codint || ba1_codemp || ba1_matric || ba1_tipreg || ba1_digito MATRICU, "
    c_Qry+= "           ba1_cpfusr CPF, "
    c_Qry+= "           ba1_nomusr NOME, "
    c_Qry+= "           bd6_nomrda PRESTAD, "
    c_Qry+= "           bd6_despro PROCEDI, "
    c_Qry+= "           bd6_qtdpro QTD_PROC, "
    c_Qry+= "           round(bd6_vlrtpf, 2) VALOR, "
    c_Qry+= "           to_date(bd6_datpro, 'YYYYMMDD') DATPRO, "
    c_Qry+= "           bm1_ano||bm1_mes MESREF , bd6.r_e_c_n_o_"

    c_Qry+= "   from " + retsqlname("BD6") + " BD6 inner join " + retsqlname("BA3") + " BA3 on "

    c_Qry+= "               ba3_filial = ' ' "
    c_Qry+= "               and ba3_codint = bd6_opeusr "
    c_Qry+= "               and ba3_codemp = bd6_codemp "
    c_Qry+= "               and ba3_matric = bd6_matric "
                      
    c_Qry+= "               inner join " + retsqlname("BA1") + " BA1 on "
    c_Qry+= "               ba1_filial = ' '     "
    c_Qry+= "               and ba1_codint = bd6_opeusr "
    c_Qry+= "               and ba1_codemp = bd6_codemp "
    c_Qry+= "               and ba1_matric = bd6_matric "
    c_Qry+= "               and ba1_tipreg = bd6_tipreg "

    c_Qry+= "               inner join " + retsqlname("BM1") + " BM1 on "
    c_Qry+= "               bm1_filial = ' '     "
    c_Qry+= "               and bm1_plnuco = bd6_numfat "
    c_Qry+= "               and bm1_numtit = bd6_numtit "         
    
    c_Qry+= "               inner join " + retsqlname("BQC") + " on "
    c_Qry+= "               bqc_codigo = bm1_codint || bm1_codemp   " 
    c_Qry+= "               and bqc_numcon = bm1_conemp             "
    c_Qry+= "               and bqc_subcon = bm1_subcon             "
	  	                                                
    c_Qry+= "   where BD6_FILIAL = ' ' "
	
	// Usa indice de numfat
	If !Empty( mv_par03 )                      
	
	    c_Qry+= "         and bd6_numfat = '" + mv_par03 + "' "	
	
	Endif

    c_Qry+= "         and BD6_OPEUSR = '0001' "
    c_Qry+= "         and BD6_CODEMP = '" + mv_par04 + "' "
    c_Qry+= "         and BM1_ANO    = '" + mv_par01 + "' "
    c_Qry+= "         and BM1_MES    = '" + mv_par02 + "' "   

    
	If !Empty(mv_par05)    	
	
	    c_Qry+= "         and BM1_CONEMP    = '" + mv_par05 + "' "
    
    EndIf
    
    If !Empty(mv_par06)    	
	
		c_Qry+= "         and BM1_SUBCON    = '" + mv_par06 + "' "
    
    EndIf
    
    c_Qry+= "         and ba3_cobniv <> '1' "                    
    c_Qry+= "         and bd6_numfat <> ' ' "
    c_Qry+= "         and bm1_codtip = '151' "

    c_Qry+= "         and BD6.d_e_l_e_t_ = ' ' "
    c_Qry+= "         and BA3.d_e_l_e_t_ = ' ' "
    c_Qry+= "         and BA1.d_e_l_e_t_ = ' ' "
    c_Qry+= "         and BM1.d_e_l_e_t_ = ' ' "
   // c_Qry+= "         and rownum = 1 "
    c_Qry+= "         ) "   
    c_Qry+= "         order by 1, 2, 3, 5      "

	
	TCQUERY c_Qry NEW ALIAS "TMPFAT"                        


TMPFAT->( dbGoTop() )

EXPEXCEL("TMPFAT")                                                               // executa a funcao excel com o arquivo temporario gerado 
IF SELECT ("TMPFAT") > 0                                                                                                                                                                                                                          // para saber se nao esta em branco 
   TMPFAT->(DBCLOSEAREA())                                                       // se esta em branco sai da rotina 
ENDIF   
                                                                        // fecha o loop 
FErase(cDirDocs+"\"+cNomeArq+".DBF")                                           // apaga o temporario 

//TMPFAT->( dbCloseArea() )

Return

STATIC FUNCTION EXPEXCEL(AREA) 
Local cPath    := AllTrim(GetTempPath()) 
Local oExcelApp 
Local cArquivo := cNomeArq 
dbSelectArea(AREA)               

X := cDirDocs+"\"+cArquivo+".DBF"       	    	
COPY TO &X VIA "DBFCDXADS" 
CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , cPath, .T. )   
//CpyS2T( cDirDocs+"\"+cArquivo+".DBF" , "\interface\exporta\Fator_Moderador\" , .T. )   

 //"C:\01\"+cArquivo+".xls" )     

IF FRENAME( cDirDocs+"\"+cArquivo+".DBF",  "\interface\exporta\Fator_Moderador\"+alltrim(MV_PAR07)+".xls"   ) = -1     
//IF FRENAME( "\interface\exporta\Fator_Moderador\"+cArquivo+".DBF" ,  "\interface\exporta\Fator_Moderador\"+alltrim(MV_PAR07)+".xls"   ) = -1     

    MsgAlert("Erro na opera็ใo: " + STR(FERROR()))
 
	BREAK    

EndIf

If ! ApOleClient( 'MsExcel' ) 
   MsgStop('MsExcel nao instalado') 
   Return Nil       

EndIf 

oExcelApp := MsExcel():New() 
oExcelApp:WorkBooks:Open( cPath+cArquivo+".DBF" ) // Abre uma planilha 
oExcelApp:SetVisible(.T.) 

Return Nil

Static Function MenuDef(c_Perg)
                                             
	PutSx1(c_Perg,"01",OemToAnsi("Ano")      			,"","","mv_ch1","C",04,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{"Tํtulo inicial para filtragem"},{""},{""})
	PutSx1(c_Perg,"02",OemToAnsi("Mes")	        		,"","","mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{"Tํtulo final para filtragem"},{""},{""})
	PutSx1(c_Perg,"03",OemToAnsi("Lote")	         	,"","","mv_ch3","C",12,0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{"Prefixo inicial para filtragem"},{""},{""})
	PutSx1(c_Perg,"04",OemToAnsi("Empresa")		     	,"","","mv_ch4","C",04,0,1,"G","","BGBPLS","","","mv_par04","","","","","","","","","","","","","","","","",{"Prefixo final para filtragem"},{""},{""})
	PutSx1(c_Perg,"05",OemToAnsi("Contrato")     		,"","","mv_ch5","C",12,0,0,"G","","CONTRA","","","mv_par05","","","","","","","","","","","","","","","","",{"Data inicial da emissใo dos tํtulos para filtro dos dados apresentados"},{""},{""})
	PutSx1(c_Perg,"06",OemToAnsi("Subcontrato")	     	,"","","mv_ch6","C",09,0,0,"G","","SUBCON","","","mv_par06","","","","","","","","","","","","","","","","",{"Data final da emissใo dos tํtulos para filtro dos dados apresentados"},{""},{""})
	PutSx1(c_Perg,"07",OemToAnsi("Caminho para arquivo"),"","","mv_ch7","C",60,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{"Data final da emissใo dos tํtulos para filtro dos dados apresentados"},{""},{""})
	         
Return                            	
        