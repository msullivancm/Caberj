#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS940VLD ºAutor  ³Jean Schulz         º Data ³  28/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para validar alteracoes na tab. padrao.    º±±
±±º          ³colo apresentado.                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS940VLD()

Local aArea := getarea()
Local nOpc := paramixb[1]
Local lRet := .T.

// INICIO 
// 21/12/2018 
// Mateus Medeiros
// Validação para os campos de SIP sempre serem preenchidos
if EMPTY(ALLTRIM(M->BR8_CLASIP)) .and. EMPTY(ALLTRIM(M->BR8_CLASP2))
	MsgAlert("Preencha as informações referente ao SIP!")
	lRet := .F.
endif

// INICIO 
// 21/12/2018 
// Mateus Medeiros
// Validação para os campos de EVOLUÇÃO sempre serem preenchidos com valores válidos
if EMPTY(M->BR8_YEVOLU) .or. padr(M->BR8_YEVOLU,tamsx3("BR8_YEVOLU")[1]) == '0 ' .or. EMPTY(M->BR8_YNEVEN) .or. padr(M->BR8_YNEVEN,tamsx3("BR8_YNEVEN")[1]) == '0 '
	MsgAlert("Favor preencher os campos de evolução do custo com valor válido.")
	lRet := .F.
endif 

// FIM 
// 21/12/2018 
// Mateus Medeiros
// Validação para os campos de SIP sempre serem preenchidos
/*
RAQUEL              SIP
1                   - 1
30                  - 58,59,60,61
31                  - 2
32                  - 21,54,23,55,24,22
33                  - 62
34,35,36,36,38,39   - 64,63
6                   - 6
7                   - 7
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso regime esteja vazio, nao permite confirmacao...               	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//lRet := !Empty(M->BR8_REGATD)  comentado em 29/03/2011, pois esse fonte está validando de acordo com o campo antigo do SIP.
/*comentado em 29/03/2011, pois esse fonte está validando de acordo com o campo antigo do SIP.
If lRet

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cfme regime, realizar validacao do evento (cfme raquel).           	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If nOpc == 1	
		lRet := M->BR8_YNEVEN < 34
	
	ElseIf nOpc == 2
		lRet := M->BR8_YNEVEN >= 34
		
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validar coerencia entre o evento (custo x evento) e o SIP.         	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	If lRet
	                 
		Do Case
			Case M->BR8_YNEVEN == 1
				lRet := M->BR8_YEVSIP == 1
			
			Case M->BR8_YNEVEN == 30                              
//				lRet := M->BR8_YEVSIP $ (58,59,60,61)
				lRet := StrZero(M->BR8_YEVSIP,2,0) $ ("58,59,60,61")  //Alterado por Luzio em 22/02/2010 as 16:46, porque ocorre erro ao comparar conjunto com valores numericos
			
			Case M->BR8_YNEVEN == 31
				lRet := M->BR8_YEVSIP == 2
			
			Case M->BR8_YNEVEN == 32
//				lRet := M->BR8_YEVSIP $ (21,54,23,55,24,22)		
//Alterado por Luzio em 22/02/2010 as 16:46, porque ocorre erro ao comparar conjunto com valores numericos
				lRet := StrZero(M->BR8_YEVSIP,2,0) $ ("21,54,23,55,24,22")		
			
			Case M->BR8_YNEVEN == 33
				lRet := M->BR8_YEVSIP == 62
			
			Case M->BR8_YNEVEN == 6
				lRet := M->BR8_YEVSIP == 6
			
			Case M->BR8_YNEVEN == 7
				lRet := M->BR8_YEVSIP == 7
			
//Alterado por Luzio em 22/02/2010 as 16:46, porque ocorre erro ao comparar conjunto com valores numericos
			Case StrZero(M->BR8_YNEVEN,2,0) $ ("34,35,36,36,38,39")     //M->BR8_YNEVEN $ (34,35,36,36,38,39)   
//				lRet := M->BR8_YEVSIP $ (64,63)
				lRet := StrZero(M->BR8_YEVSIP,2,0) $ ("64,63")
					
		EndCase
		
		If !lRet
			MsgAlert("Eventos incompativeis entre os campos de regime de atendimento, relatorio gerencial e o SIP. Verifique")
		Endif
	
	
	/*
	//COMENTADO. AGUARDANDO NOVO FORMATO DO SIP.
		If M->BR8_REGATD == "1" //Ambulatorial
			If Empty(M->BR8_YITGAM)
				MsgAlert("Preencha item gerencial relativo ao regime ambulatorial!")
				lRet := .F.
			Endif
		
		ElseIf M->BR8_REGATD == "2" //Internacao
		
			If Empty(M->BR8_YITGIN)
				MsgAlert("Preencha item gerencial relativo ao regime de internacao!")
				lRet := .F.
			Endif
		
		
		Else //Ambos
			If Empty(M->BR8_YITGIN) .Or. Empty(M->BR8_YITGAM)
				MsgAlert("Preencha item gerencial relativo ao regime Ambos!")
				lRet := .F.
			Endif
		
		Endif  
	*/	 
/*	
	Endif
		
Endif */
	
	RestArea(aArea)
	
Return lRet