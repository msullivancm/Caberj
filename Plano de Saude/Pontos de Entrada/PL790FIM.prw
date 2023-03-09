/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |PL790FIM  ºAutor  ³Jean Schulz         º Data ³  14/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada desenvolvido pra alterar a situacao       º±±
±±º          ³ de uma guia odontologica para bloqueada depois de auditada º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL790FIM
	Local aAreaBD5 	:= BD5->(GetArea())
	Local aAreaBD6 	:= BD6->(GetArea())
	Local aAreaBD7 	:= BD7->(GetArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua busca...                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If BCL->BCL_TIPGUI <> "03" .AND. BD5->BD5_SIGLA = "CRO" //nao eh internacao e eh odontologica

		If BEA->(BEA_CODLDP+BEA_CODPEG+BEA_NUMGUI) == BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)

			BD5->(RecLock("BD5",.F.))
			BD5->BD5_SITUAC := "3"
			BD5->(MsUnlock())

			BD6->(DbSetOrder(1))
			BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))

			While !BD6->(Eof()) .And. ( BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV) == BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) )

				BD6->(RecLock("BD6",.F.))
				BD6->BD6_SITUAC := "3"
				BD6->(MsUnlock())				
				BD6->(DbSkip())  

			Enddo

			BD7->(DbSetOrder(1))
			BD7->(MsSeek(xFilial("BD7")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))

			While !BD7->(Eof()) .And. ( BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV) == BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV) )

				BD7->(RecLock("BD7",.F.))
				BD7->BD7_SITUAC := "3"
				BD7->(MsUnlock())				
				BD7->(DbSkip())  

			Enddo

		Endif

	Endif


	BD5->(RestArea(aAreaBD5))
	BD6->(RestArea(aAreaBD6))
	BD7->(RestArea(aAreaBD7))

	if M->BVX_PARECE == '0'
		BE4->( RecLock("BE4", .F.) )
		BE4->BE4_YMEDAN := u_PreviAn(BE4->BE4_CODOPE, BE4->BE4_ANOINT, BE4->BE4_MESINT, BE4->BE4_NUMINT, nOpca, BA1->BA1_CODINT, BA1->BA1_CODEMP, BA1->BA1_MATRIC, BA1->BA1_TIPREG, BA1->BA1_DIGITO, BA3->BA3_CONEMP, BA3->BA3_VERCON, BA3->BA3_SUBCON, BA3->BA3_VERSUB, FUNNAME())
		BE4->( MsUnLock() )         
	Endif

	lRefresh := .T.   
Return