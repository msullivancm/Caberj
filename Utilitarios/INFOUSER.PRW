#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#DEFINE C_ENT CHR(13) + CHR(10)



/*------------------------------------------------------------------------\
| FUNCAO    | INFOUSER | OTAVIO PINTO                  | DATA | 11/03/15  |
|-------------------------------------------------------------------------|
| DESCRICAO | LE DADOS DOS USUARIOS CADASTRADOS NO PROTHEUS.              |
|-------------------------------------------------------------------------|
| USO       | USUARIOS COM PERMISS„O - GETIN                              |
|           |                                                             |
|-------------------------------------------------------------------------|
| ID        | LOGIN                                                       |
|           |                                                             |
| 000891    | ALEXANDRE                                                   |
| 000340    | BIANCHINI                                                   |
| 000304    | CASEMIRO                                                    |
| 000791    | FABIOSANTOS                                                 |
| 000395    | INFRA                                                       |
| 000525    | LEONARDO.PORTEL                                             |
| 000786    | MARCO.BELLIO                                                |
| 000305    | MOTTA                                                       |
| 000668    | OTAVIO                                                      |
| 000064    | PIUMBIM                                                     |
| 000843    | SERGIO.CUNHA                                                |
| 001262    | ANDERSON.RANGEL                                             |
|           |                                                             |
------------------------------------------------------------------------*/
USER FUNCTION INFOUSER()
	PRIVATE CLIBOPC   := GETNEWPAR("MV_YACCESS","000891,000340,000304,000791,000395,000525,000786,000305,000668,000064,000843,001262,001263")
	
	IF ( __CUSERID $ ALLTRIM(CLIBOPC) )
		IF MSGBOX("EXPORTA DADOS DOS USU·RIOS CADASTRADOS NO PROTHEUS"+CHR(13)+;
				"O ARQUIVO INFOUSER.CSV ESTAR· DISPONÌVEL NA PASTA C:\TEMP",;
				"SELECIONE",;
				"YESNO")
			PROCESSA({|| F_EXPORT() })
		ENDIF
	ELSE
		MSGSTOP("VOCE N„O EST· HABILITADO A EXECUTAR ESTA ROTINA..."+CHR(13)+CHR(13)+;
			"PROCURE SUA CHEFIA E PEÁA PARA CADASTR·-LO NO PARAMETRO"+CHR(13)+;
			"MV_YACCESS COM O ID UTILIZADO NO PROTHEUS."            )
	ENDIF
	
RETURN


/*------------------------------------------------------------------------
|  F_EXPORT()                                                             |
|  FAZ LEITURA DO ARQUIVO SIGAPSS.SPF E MONTA UMA LISTA COM DADOS         |
|  DOS USU·RIOS CADASTRADOS NO PROTHEUS.                                  |
------------------------------------------------------------------------*/
STATIC FUNCTION F_EXPORT()
	PRIVATE CCRLF       := CHR(13)+CHR(10)
	PRIVATE _CPATH		:= "C:\TEMP\"
	PRIVATE _CARQUIVO  	:= "INFOUSER.CSV"
	PRIVATE CBUFFER		:= ""
	PRIVATE NHANDLE
	PRIVATE CMENUS 		:= ''
	PRIVATE NQTDRG      := 0 //1368 -- Angelo Henrique - Data: 16/10/2019 -- Removendo o limitador de usu·rios e passando para par‚metro
	PRIVATE CCRA 		:= ''
	PRIVATE _CPARAM		:= ''
	PRIVATE NACES		:= ''
	PRIVATE CDPTO		:= ''
	PRIVATE CDATA		:= ''
	PRIVATE CBLOQ		:= ''
	PRIVATE CPERG 		:= "INFOUSER"
	
	AJUSTASX1(CPERG)
	
	IF !PERGUNTE(CPERG,.T.)
		RETURN
	ENDIF
	
	
	FERASE( _CPATH+_CARQUIVO )
	
	NHANDLE := FCREATE( _CPATH + "\" + _CARQUIVO)
	
	BEGIN SEQUENCE
		
		IF NHANDLE == -1
			MSGSTOP("ERRO NA CRIACAO DO ARQUIVO NA ESTACAO LOCAL. CONTATE O ADMINISTRADOR DO SISTEMA")
			RETURN
		ENDIF
		
		//---------------------------------------------
		//Angelo Henrique - Data: 16/10/2019
		//---------------------------------------------
		NQTDRG := MV_PAR02
		
		PROCREGUA( NQTDRG )
		
		CLINHA  := PADR("ID"             ,006," ")+";"+;
			PADR("LOGIN"          ,015," ")+";"+;
			PADR("NOME_COMPLETO"  ,030," ")+";"+;
			PADR("VALIDADE"       ,008," ")+";"+;
			PADR("BLOQ"           ,003," ")+";"+;
			PADR("QTD_ACESS"	  ,009," ")+";"+;
			PADR("CC"	   		  ,040," ")+";"+;
			PADR("DTPO"	   		  ,040," ")+";"+;
			PADR("MENUS"          ,1000," ")
		FWRITE(NHANDLE, CLINHA) ; FWRITE(NHANDLE, CCRLF)
		
		PSWORDER(1) // ORDEM DE ID            SERGIO.CIUNA
		FOR X := 1 TO NQTDRG
			
			INCPROC( "LENDO O ID... "+STRZERO( X,6 ) )
			
			IF PSWSEEK( STRZERO(X,6), .T. )
				CDATA := PSWRET(1)[1][06]
				CBLOQ := IF(PSWRET(1)[1][17]," S "," N ")
				NACES := PSWRET(1)[1][15]
				CDPTO := PSWRET(1)[1][12]
				C_MATRIC := PSWRET(1)[1][22]
				CQUERY := "SELECT CTT.CTT_DESC01 CC" +C_ENT
				CQUERY += "FROM SRA010 SRA, CTT010 CTT" +C_ENT
				CQUERY += "WHERE TRIM(SRA.RA_CC) = TRIM(CTT.CTT_CUSTO)" +C_ENT
				CQUERY += "AND SRA.RA_MAT = '"+SUBSTR(C_MATRIC,5,10)+"'" +C_ENT
				
				IF SELECT(("R179B")) <> 0
					("R179B")->(DBCLOSEAREA())
				ENDIF
				
				TCQUERY CQUERY NEW ALIAS ("R179B")
				
				DBSELECTAREA("R179B")
				
				("R179B")->(DBGOTOP())
				
				IF !R179B->(EOF())
					IF !(EMPTY(R179B->CC))
						CCRA := R179B->CC
					ELSE
						CCRA := ' '
					ENDIF
				ELSE
					CCRA := ' '
					
					
					
				ENDIF
				
				CMENUS:=' '
				FOR Y:=1 TO LEN(PSWRET(3)[1]) //,008," ")+";"+;
						// IF  SUBSTR(PSWRET(3)[1][Y],3,1) !$ 'X'// ALTERADO POR MARCELA COIMBRA
					IF  SUBSTR(PSWRET(3)[1][Y],3,1) <> 'X'
						CMENUS  += PSWRET(3)[1][Y] + ', '
					ENDIF
				NEXT Y
				
				IF ALLTRIM(MV_PAR01) = '1'
					
					_CPARAM := "S"
					
				ELSEIF ALLTRIM(MV_PAR01) = '2'
					
					_CPARAM := "N"
				ELSE
					
					_CPARAM := " " //AMBOS
					
				ENDIF
				
				
				
				IF TRIM(CBLOQ) = _CPARAM .OR. _CPARAM = " " //AMBOS
					
					CLINHA  := PADR(PSWRET(1)[1][01] ,006," ")+";"
					CLINHA  += PADR(PSWRET(1)[1][02] ,015," ")+";"
					CLINHA  += PADR(PSWRET(1)[1][04] ,030," ")+";"
					CLINHA  += PADR(PSWRET(1)[1][06] ,008," ")+";"
					
					
					CLINHA  += PADR(IIF(PSWRET(1)[1][17]," S "," N ") ,003," ")+";"
					CLINHA  += PADR(PSWRET(1)[1][15] ,002," ")+";"
					CLINHA  += PADR(CCRA,040," ")+";"
					CLINHA  += PADR(CDPTO,040," ")+";"
					CLINHA  += CMENUS+";"
					
					
					
					FWRITE(NHANDLE, CLINHA) ; FWRITE(NHANDLE, CCRLF)
					
				ENDIF
			ENDIF
		NEXT
		CFINAL := "FIM "
		FWRITE(NHANDLE, CFINAL)
	END SEQUENCE
	FCLOSE(NHANDLE)
	
STATIC FUNCTION AJUSTASX1
	
	
	LOCAL AHELPPOR := {}
	//MONTA HELP
	
	u_CABASX1(CPERG,"01","BLOQUEADOS?:  "  						,"","","MV_CH01","C",01,0,0,"C","","","","","MV_PAR01","SIM"    ,"","","","NAO"  ,"","","AMBOS"	,"","","","","","","","",{},{},{})
	
	//-----------------------------------------------------------------------------------------------------
	//Angelo Henrique - Data: 16/10/2019
	//-----------------------------------------------------------------------------------------------------
	//Colocado para remover o limitador de quantos usu·rios existem cadastrados no Protheus
	//-----------------------------------------------------------------------------------------------------
	u_CABASX1(CPERG,"02","Ultimo ID do Usuario Criado ?:  "  	,"","","MV_CH02","N",06,0,0,"G","","","","","MV_PAR02",""		,"","","",""	,"","",""		,"","","","","","","","",{},{},{})
	//-----------------------------------------------------------------------------------------------------
	
RETURN


