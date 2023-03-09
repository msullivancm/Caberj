#INCLUDE 'FWPRINTSETUP.CH'
#INCLUDE     'PROTHEUS.CH'
#INCLUDE       'RPTDEF.CH'
#INCLUDE       'RWMAKE.CH'
#INCLUDE        'TOTVS.CH'

// +--------------------------------------------------------------------------+
// | Programa  : xinadimp.prw     | Jean Schulz                  | 16/08/2006 |
// +--------------------------------------------------------------------------+
// | Descricao : Impressao de carta de inadimplencia para usuarios            |
// |             repassados por parametro.                                    |
// |             Repassar matriz de usuarios a imprimir. Impressao de carta.  |
// +--------------------------------------------------------------------------+
// ------------------------------------
//	Layout Matriz aCarta (Dimensoes)
// ------------------------------------
//	1-Nome Cliente
//	2-Logradouro + Numero + Complemento
//	3-Bairro
//	4-Cidade
//	5-Estado
//	6-Cep
//	7-Valor devido
//	8-Data limite para comparecimento // Sem uso
// ------------------------------------
//user function xinadimp( aCarta , dDatRef )
 user function inadimp( aCarta , dDatRef , cCabInt , cCodEmp )

// ------------------------------------
//	local   cMask102 := '@E 999,999.99' // gus
//	local   nLin     := 0               // gus
	local   cPath    := getsrvprofstring( 'Startpath' , '' )
//  local   cContato := getnewpar( 'MV_YDEBCO' , 'Telefone (21) 2505-6446 Ramais: 9856 e 9809 das 10:00h as 16:00h.' )
//	local   cAssina1 := getnewpar( 'MV_YDBASS' , 'Gerência Financeira' )
//	local   cAssina2 := getnewpar( 'MV_YDBAS2' , 'Cobrança' )
//	local   cAssina3 := getnewpar( 'MV_YDBAS3' , 'Caberj'   )
//	local   cLogoCli := '' // gus
	local   cLogoANS := ''
	local   nCont    := 0
//	local   bLin     := { | nLinha , nMult | nLinha += ( 45 * nMult ) , nLin := nLinha } // gus
// ------------------------------------
//	local   nPasso   := 130
	local   _lMater  := .T.
	Local   _lOdonto := .F.
	local   _aFat    := {}
	local   _nz      := 0
	local   ni       := 0
// -[ gus - ini ]----------------------
    private nPasso   := 130
    private nLin     := 0
    private bLin     := { | nLinha , nMult | nLinha += ( 45 * nMult ) , nLin := nLinha }
    private cLogoCli := ''
	private cMask102 := '@E 999,999.99'
	private cAssina1 := getnewpar( 'MV_YDBASS' , 'Gerência Financeira' )
	private cAssina2 := getnewpar( 'MV_YDBAS2' , 'Cobrança' )
	private cAssina3 := getnewpar( 'MV_YDBAS3' , 'Caberj'   )
	private lPF      := .F.
	private lPJ 	 := .F.

	Private cRodape1 := getnewpar( 'MV_YDBRP1' , 'Departamento Financeiro' )
	Private cRodape2 := getnewpar( 'MV_YDBRP2' , 'Rua do ouvidor,91 - Centro - Rio de Janeiro - CEP: 20040-031' )
	Private cRodape3 := getnewpar( 'MV_YDBRP3' , 'Telefone: (21)3233-8888 - www.caberj.com.br - faleconosco@caberj.com.br' )
// ------------------------------------
	default dDatRef  := NIL
// ------------------------------------
	if !( valtype( dDatRef ) = 'C' ) .OR. dDatRef == '  /  /    '
		dDatRef := dtoc( dDataBase )
	endif
// ------------------------------------

// ------------------------------------
//  [ Define logos a serem utilizadas... ]
// ------------------------------------
	cPath    := AjuBarPath( cPath )
	cLogoANS := cPath + 'LogoANS.bmp'
// ------------------------------------
	    if cEmpAnt = '01'
//		cLogoCli  := '\\10.19.1.10\p12hmlog\protheus_data\system\lgrl01.bmp'
		cLogoCli  := cPath + 'lgrl01.bmp'
	elseif cEmpAnt = '02'
//		cLogoCli  := '\\10.19.1.10\p12hmlog\protheus_data\system\lgrl02.bmp'
		cLogoCli  := cPath + 'lgrl02.bmp'
	endif
// ------------------------------------
//  [ Define fontes a serem utilizadas... ]
// ------------------------------------
	oFont1 := TFont():New( 'Times New Roman' ,, 14 ,, .T. ,,,,, .F. )
	oFont2 := TFont():New( 'Courier New'     ,, 13 ,, .T. ,,,,, .F. )
	oFont3 := TFont():New( 'Courier New'     ,, 11 ,, .T. ,,,,, .F. )
	oFont4 := TFont():New( 'Courier New'     ,, 14 ,, .T. ,,,,, .F. )
	oFont5 := TFont():New( 'Courier New'     ,, 16 ,, .T. ,,,,, .F. )
	oFont6 := TFont():New( 'Courier New'     ,, 14 ,, .T. ,,,,, .F. )
	oFont9 := TFont():New( 'Courier New'     ,, 15 ,, .T. ,,,,, .F. )

	oFont7 := TFont():New( 'Courier New'     ,, 17 ,, .T. ,,,,, .T. )
	oFont8 := TFont():New( 'Courier New'     ,, 17 ,, .T. ,,,,, .F. )

// ------------------------------------
//  [ Cria objeto de impressao grafica... ]
// ------------------------------------
//  https://tdn.totvs.com/display/public/framework/FWMsPrinter
// ------------------------------------
//	oPrn := FWMSPrinter():New( 'Protheus_Inadimp' , IMP_PDF , .T. ,           , .T. , .T. , , , , , , .T. )
//	oPrn := FWMSPrinter():New( 'Protheus_Inadimp' , IMP_PDF , .T. , 'C:\TEMP' , .T. , .T. , , , , , , .T. )
	oPrn := FWMSPrinter():New( 'Protheus_Inadimp' , IMP_PDF , .T. ,           , .T. , .T. , , , , , , .T. )
	oPrn:cPathPDF := 'C:\TEMP\'
//	oPrn:Setup()

// ------------------------------------
//  [ Rotina de impressao da carta... ]
// ------------------------------------
	for nCont := 1 to len( aCarta )

		oPrn:StartPage()

//----------------------------------------------------------
//      [ Inicio - Angelo Henrique - Data: 03/12/2015 ]
//----------------------------------------------------------
//      Chamado: 22414 - Solicitado que quando for Mater
//      a carta será diferenciada, para afinidade foi decidido
//      que a carta atual já atendia, porém para MATER foi
//      solicitado um novo modelo
//----------------------------------------------------------

		lPrefeitura := .F.

		if len( aCarta[nCont] ) == 10 .OR. ;
           len( aCarta[nCont] )  > 10

			if alltrim( aCarta[nCont,10] ) == '0001' // MATER
				_lMater     := .T.
			elseif alltrim( aCarta[nCont,10] ) == '0024' // Prefeitura
				lPrefeitura := .T.
			elseif alltrim( aCarta[nCont,10] ) == '5007' // Odonto    //Adicionado por Luiz Otavio 26/09/2022 -> Inad fase 2
				_lOdonto := .T.	
			else
				_lMater     := .F.
			endif

		else
			_lMater := .F.
		endif


//----------------------------------------------------------
//      [ Fim - Angelo Henrique - Data: 03/12/2015 ]
//----------------------------------------------------------
// function xinadimp( aCarta , dDatRef , cCabInt , cCodEmp )
// aqui - gus

        if ( cCabInt == 'Integral' .AND. ;
             cCodEmp == "'PF'" )

            lPF := .T.
            u_InaIntPF( aCarta , nCont , dDatRef )


        elseif ( cCabInt == 'Integral' .AND. ;
             cCodEmp == "PJ" )

			u_InaIntPJ( aCarta , nCont , dDatRef )
			lPJ := .T.

		elseif !lPrefeitura	// gus	

			// ---------[ Logo da operadora... ]------------------------
			If  cEmpAnt = '02'
				oPrn:SayBitmap( 048 ,    130 , cLogoCli , 300 , 450 )
			Else 
				oPrn:SayBitmap( 048 ,    130 , cLogoCli , 300 , 300 )
			EndIf		

			// ------------------------------------
			//          [ Dados do cliente... ]
			// ------------------------------------
			oPrn:Say ( 295 , nPasso + 400 ,          aCarta[nCont,1]   , oFont5 , 100 ) // NOME CLIENTE
			oPrn:Say ( 335 , nPasso + 400 ,          aCarta[nCont,2]   , oFont5 , 100 ) // LOGRADOURO + NRO + COMPLEMENTO
			oPrn:Say ( 375 , nPasso + 400 , alltrim( aCarta[nCont,3] ) + ;
                                    ' - ' + alltrim( aCarta[nCont,4] ) + ;
                                    ' - ' + alltrim( aCarta[nCont,5] ) , oFont5 , 100 ) // BAIRRO + CIDADE + ESTADO
			oPrn:Say ( 415 , nPasso + 400 ,          aCarta[nCont,6]   , oFont5 , 100 ) // CEP

			oPrn:Say ( 245 , 1600 , 'Data Emissão: '  + dtoc( dDataBase )  , oFont5 , 100 ) // NOME CLIENTE
			oPrn:Say ( 495 , 1600 , 'OFICIO ' + substr( dtos( dDataBase )  ,      3 ,   2 ) + ;
                                            strzero( aCarta[nCont,9] , 8 ) , oFont5 , 100 ) // NUMERO DO OFICIO

			// ------------------------------------
			//          [ Inicio da impressao do texto da carta... ]
			// ------------------------------------
			nLin := 525 // 445

		endif

		if !lPF .and. !lPJ// gus			

		if (!_lMater .AND.  !lPrefeitura ) .Or. _lOdonto  // Se for afinidade permanecer a carta já utilizada

			oPrn:Line( Eval( bLin , nLin , 1 ) , nPasso , nLin , 2400 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Prezado (a)  Beneficiário(a), "                                                    , oFont5 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Como você já sabe, a Caberj é  uma instituição  que tem como objetivo oferecer ao" , oFont6 , 100 )

			If _lOdonto //Adicionado por Luiz Otavio Campos 26/09 - Inadimplecia fase 2 
				oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "seu quadro de  assistidos um  plano odonológico com cobertura abrangente, benefícios" , oFont6 , 100 )
			else
				oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "seu quadro de  assistidos um  plano de saúde com cobertura abrangente, benefícios" , oFont6 , 100 )
			EndIf		
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "além dos previstos  pela  ANS,  incorporando  novas  tecnologias  e, mesmo assim," , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "buscando praticar um valor de  contribuição  inferior aos cobrados pelo mercado. " , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Ocorre que todas as empresas de  assistência  médica são reguladas  pela  Agência" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "Nacional de Saúde Suplementar, ANS, que prevê o desligamento  do  usuário que  se" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "encontram  com  as suas  contribuições  em atraso  por  um  período  de  60  dias" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "cumulativos,  durante  a  vigência  anual  do  contrato  (Lei  9656/98).  Caso  a" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "operadora não adote providências nesse sentido, poderá ser multada.              " , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Por essa razão, estamos  realizando esse  contato para informar  que  encontramos"            , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "em nossos registros um débito no valor de R$" + transform( aCarta[nCont,7] , cMask102 ) + '.' , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "A nossa relação é de parceria e, por isso, pedimos  que entre em contato conosco," , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "por  meio  do  nosso  site  (link Fale Conosco) ou  telefone abaixo especificado," , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "para que possamos esclarecer o assunto e buscar a melhor solução para o problema." , oFont6 , 100 )

//------------------------------------------------------------------
//          [ Inicio - Angelo Henrique - Data: 23/12/2016 - Chamado: 33531 ]
//------------------------------------------------------------------
//          Mudado a carta do afinidade para seguir com as mesmas 
//          informações da carta do MATER, as informações anteriores
//          foram removidas.
//------------------------------------------------------------------			
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Pendências identificadas até " + dDatRef + "." , oFont6 , 100 )

// ------------------------------------
//          Fatura do mês __/__ : R$ x.xxx.xx
//          Fatura do mês __/__ : R$ x.xxx.xx
// ------------------------------------
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Total: " + transform( aCarta[nCont,7] , cMask102) + '.' , oFont6 , 100 )

			_aFat := separa( alltrim( aCarta[nCont,11] ) , '-' , .T. )

// ------------------------------------
			for _nz := 1 to len( _aFat )
				_aFat[_nz] := { substr( alltrim( _aFat[_nz] ) , 5 , 4 ) + ;
					substr( alltrim( _aFat[_nz] ) , 1 , 3 ) , alltrim( _aFat[_nz] ) }
			next _nz
			_aFat[_nz-1] := { '999999' , '' }
			_aFat        := asort( _aFat ,,, { | x,y | x[1] < y[1] } )
// ------------------------------------
			for _nz := 1 to len( _aFat )
				if _nz != len( _aFat )
					if _nz = 1
//                      oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz])    + "." , oFont6 , 150 )
						oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					else
//                      oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz])    + "." , oFont6 , 150 )
						oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					endif
				endif
			next _nz
// ------------------------------------
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Solicitamos que o contato seja realizado até " + dtoc( aCarta[nCont,8] ) +  '. ' , oFont5 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Ressaltamos  que,  caso  o  pagamento  já  tenha  sido  realizado, solicitamos " , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "desconsiderar  esta  correspondência   e  nos  contactar   através   do  canal " , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "exclusivo abaixo ou encaminhar o comprovante  de  pagamento, para que possamos " , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "processar a baixa da pendência em nosso sistema e informar imediatamente à "     , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "ANS – Agência Nacional de Saúde Suplementar. "                                   , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Telefone (21) 3233-8855"                                                                    , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Site: www.caberj.com.br  " , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 3 ) , nPasso , "Cordialmente," , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 5 ) , nPasso , cAssina1 , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , cAssina2 , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , cAssina3 , oFont6 , 100 )

//------------------------------------------------------------------
//          [ Inicio - Angelo Henrique - Data: 23/12/2016 - Chamado: 33531 ]
//------------------------------------------------------------------

		elseif lPrefeitura

			bLinP    := { | nLinha , nMult | nLinha += ( 55 * nMult ) , nLin := nLinha }

			oFontP   := TFont():New( 'Courier New' ,, 12 ,, .F. ,,,,, .F. )
			oFontPN  := TFont():New( 'Courier New' ,, 12 ,, .T. ,,,,, .F. )
			oFontPNS := TFont():New( 'Courier New' ,, 12 ,, .T. ,,,,, .T. )

			nColMax  :=  76 // Caracteres
			nTab     := 200 // Pixels
			nLin     := 120

// ------------------------------------
//          [ Logo da operadora... ]
// ------------------------------------
			oPrn:SayBitmap( nLin , nPasso , cLogoCli , 350 , 200 )
			oPrn:Say ( nLin , nPasso , cAlinDir( 'Data de Emissão: ' + dtoc( dDataBase ) , nColMax ) , oFontPN , 100 )

// ------------------------------------
//          [ Dados do cliente... ]
// ------------------------------------
			nLin += 280
			oPrn:Say ( nLin , nPasso+nTab ,          aCarta[nCont,1]   , oFontPN , 100 ) // NOME CLIENTE
			nLin += 88
			oPrn:Say ( nLin , nPasso+nTab ,          aCarta[nCont,2]   , oFontPN , 100 ) // LOGRADOURO + NRO + COMPLEMENTO
			nLin += 40
			oPrn:Say ( nLin , nPasso+nTab , alltrim( aCarta[nCont,3] ) + ;
                                    ' - ' + alltrim( aCarta[nCont,4] ) + ;
                                    ' - ' + alltrim( aCarta[nCont,5] ) , oFontPN , 100 ) // BAIRRO + CIDADE + ESTADO
			nLin += 40
			oPrn:Say ( nLin , nPasso+nTab ,          aCarta[nCont,6]   , oFontPN , 100 ) // CEP
			nLin += 80
			oPrn:Say ( nLin , nPasso      , cAlinDir( alltrim( 'OFICIO '   + ;
			                           substr( dtos( dDataBase ) , 3 , 2 ) + ;
									        strzero( aCarta[nCont,9] , 8 ) ) , nColMax ) , oFontPNS , 100 ) // NUMERO DO OFICIO
			nLin += 30

// ------------------------------------
//          [ Inicio da impressao do texto da carta... ]
// ------------------------------------
			oPrn:Say ( Eval( bLinP , nLin , 2 ) , nPasso , 'Prezado (a) Servidor (a),' , oFontP , 100 )

			Eval( bLinP , nLin , 1 )

			aSays := aQuebraTxt( 'Informamos que identificamos em nossos registros um débito referente ao seu plano de saúde no valor de R$ ' + ;
                                  alltrim( transform( aCarta[nCont,7] , '@E 999,999,999.99' ) ) + ;
                                 ', referente a perda de margem consignável junto a PREVI-RIO, conforme abaixo:' , nColMax )

			for nI := 1 to len( aSays )
				oPrn:Say ( Eval( bLinP , nLin , 1 ) , nPasso , aSays[nI] , oFontP , 100 )
			next nI

			oPrn:Say ( Eval( bLinP , nLin , 2 ) , nPasso , "Total: R$ " + alltrim( transform( aCarta[nCont,7],'@E 999,999,999.99' ) ) + "." , oFontPN , 100 )

			_aFat := separa( alltrim( aCarta[nCont,11] ) , '-' , .T. )

			Eval( bLinP , nLin , 1 )

			for _nz := 1 to len( _aFat )
				if _nz <> len( _aFat )
					oPrn:Say ( Eval( bLinP , nLin , 1 ) , nPasso , "Fatura: " + alltrim( _aFat[_nz] ) + "." , oFontPN , 150 )
				endif
			next _nz

			Eval( bLinP , nLin , 1 )

			aSays := aQuebraTxt( 'A regularização da pendência financeira acima é de suma importância para a manutenção da sua assistência médica. Por esse motivo solicitamos contato urgente para regularização do débito.' , nColMax )

			for nI := 1 to len( aSays )
				oPrn:Say ( Eval( bLinP , nLin , 1 ) , nPasso , aSays[nI] , oFontP , 100 )
			next nI

			aSays := aQuebraTxt( 'Ressaltamos que, caso o pagamento já tenha sido realizado, solicitamos desconsiderar esta correspondência e nos contactar através do canal exclusivo abaixo ou encaminhar o comprovante de pagamento, para que possamos processar a baixa da pendência em nosso sistema e informar a regularização junto a PREVI-RIO.' , nColMax )

			Eval( bLinP , nLin , 1 )

			for nI := 1 to len( aSays )
				oPrn:Say ( Eval( bLinP , nLin , 1 ) , nPasso , aSays[nI] , oFontP , 100 )
			next nI

			oPrn:Say ( Eval( bLinP , nLin , 2 ) , nPasso , "Solicitamos que o contato seja realizado até " + dtoc( aCarta[nCont,8] ) + "." , oFontPN , 100 )

			oPrn:Say ( Eval( bLinP , nLin , 2 ) , nPasso , "Telefone (21) 3233-8855"           , oFontP , 100 )
			oPrn:Say ( Eval( bLinP , nLin , 1 ) , nPasso , "email: faturamento2@caberj.com.br" , oFontP , 100 )

			oPrn:Say ( Eval( bLinP , nLin , 3 ) , nPasso , "Atenciosamente,"                   , oFontP , 100 )
			oPrn:Say ( Eval( bLinP , nLin , 2 ) , nPasso , "Grupo Caberj"                      , oFontP , 100 )

		else

//--------------------------------------
//--------------------------------------
//          Angelo Henrique - Data: 03/12/2015
//--------------------------------------
//--------------------------------------
//          Carta para os associados Mater
//          Modelo diferente
//--------------------------------------
//--------------------------------------

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "ASSUNTO: REGULARIZAÇÃO DE PENDÊNCIAS " , oFont5 , 100 )
			oPrn:Line( Eval( bLin , nLin , 1 ) , nPasso , nLin , 2400 )
// ------------------------------------
//          oPrn:Say (Eval(bLin,nLin,2), nPasso, "Prezado (a)  Beneficiário(a), "																,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,2), nPasso, "Reportamo-nos a você associado Mater, para reafirmar o nosso irrestrito compromisso com você"	,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "ex-funcionário do Banco BANERJ." 																,oFont6,100)
//
//          oPrn:Say (Eval(bLin,nLin,2), nPasso, "Sabemos  das  dificuldades  em  manter  um  plano  de  saúde e do esforço que certamente tem"	,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "empreendido  no  sentido  de  evitar situações que possam por em risco a continuidade de sua" ,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "assistência. É  por  essa  razão que realizamos esse contato,  para tentarmos ajudá-lo a    " ,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "superar possíveis dificuldades.    														  " ,oFont6,100)
//
//          oPrn:Say (Eval(bLin,nLin,2), nPasso, "Seguindo  essa  linha  de raciocínio, preocupa-nos a identificação das pendências abaixo, as"	,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "quais  necessitam  de  regularização, razão pela qual solicitamos o seu urgente contato para"	,oFont6,100)
//          oPrn:Say (Eval(bLin,nLin,1), nPasso, "que possamos buscar a melhor alternativa visando à preservação de sua assistência médica."	,oFont6,100)
// ------------------------------------

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Prezado (a)  Associado(a), "                                                                  , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Reportamo-nos a você associado Mater, para reafirmar o nosso irrestrito compromisso com você" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "ex-funcionário do Banco BANERJ."                                                              , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Como  você  deve  saber, a CABERJ tem a obrigação legal de informar à ANS - Agência Nacional" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "de  Saúde  Suplementar a inadimplência dos associados, transcorridos sessenta dias de atraso" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "no plano de saúde e promover o cancelamento do plano (Lei 9656/98)."                          , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Sabemos  das  dificuldades  em  manter  um  plano  de  saúde e do esforço que certamente tem" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "empreendido  no  sentido  de  evitar situações que possam por em risco a continuidade de sua" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "assistência."                                                                                 , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "É  por  essa  razão que realizamos esse contato, para tentarmos ajudá-lo a superar possíveis" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "dificuldades."                                                                                , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Seguindo  essa  linha  de raciocínio, preocupa-nos a identificação das pendências abaixo, as" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "quais  necessitam  de  regularização, razão pela qual solicitamos o seu urgente contato para" , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "que possamos buscar a melhor alternativa visando à preservação de sua assistência médica."    , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Pendências identificadas até " + dDatRef + "."                                                , oFont6 , 100 )

// ------------------------------------
//          Fatura do mês __/__ : R$ x.xxx.xx
//          Fatura do mês __/__ : R$ x.xxx.xx
// ------------------------------------

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Total: " + transform( aCarta[nCont,7] , cMask102 ) + "." , oFont6 , 100 )

			_aFat := separa( alltrim( aCarta[nCont,11] ) , '-' , .T. )

			for _nz := 1 to len( _aFat )
				if _nz != len( _aFat )
					if _nz = 1
						oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz]) + "." , oFont6 , 150 )
					else
						oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "Fatura: " + alltrim(_aFat[_nz]) + "." , oFont6 , 150 )
					endif
				endif
			next _nz
// ------------------------------------
//          Angelo Henrique - Data: 29/12/2016 - Chamado 33531
// ------------------------------------
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Solicitamos que o contato seja realizado até " + dtoc( aCarta[nCont,8] ) + "." , oFont5 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Ressaltamos que, caso o pagamento já tenha sido realizado, solicitamos desconsiderar esta"  , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "correspondência  e  nos  contactar  através  do  canal  exclusivo  abaixo ou encaminhar o"  , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "comprovante  de  pagamento,  para  que  possamos  processar a baixa da pendência em nosso"  , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , "sistema e informar imediatamente à ANS – Agência Nacional de Saúde Suplementar."            , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Telefone (21) 3233-8855"                                                                    , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 2 ) , nPasso , "Site: www.caberj.com.br  " , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 3 ) , nPasso , "Cordialmente," , oFont6 , 100 )

			oPrn:Say ( Eval( bLin , nLin , 5 ) , nPasso , cAssina1 , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , cAssina2 , oFont6 , 100 )
			oPrn:Say ( Eval( bLin , nLin , 1 ) , nPasso , cAssina3 , oFont6 , 100 )

		endif

			if !lPrefeitura

				// ------------------------------------
				//          [ Logo ANS + Rodape ]
				// ------------------------------------
				oPrn:Line(      Eval( bLin , nLin , 33 ) , nPasso , nLin     ,   2400       )
				oPrn:SayBitmap( Eval( bLin , nLin ,  2 ) , nPasso , cLogoANS ,    250 ,  60 )
				oPrn:Say (      Eval( bLin , nLin ,  3 ) , nPasso , cRodape1 , oFont5 , 100 )
				oPrn:Say (      Eval( bLin , nLin ,  1 ) , nPasso , cRodape2 , oFont5 , 100 )
				oPrn:Say (      Eval( bLin , nLin ,  1 ) , nPasso , cRodape3 , oFont5 , 100 )

			endif

		endif // gus

		oPrn:EndPage()

	next nCont

// ------------------------------------
//  [  Apresenta o resultado... ]
// ------------------------------------
	oPrn:Preview()
//  oPrn:Print() 

return

// +--------------------------------------------------------------------------+
// | Funcao : aQuebraTxt                                                      |
// +--------------------------------------------------------------------------+

static function aQuebraTxt( cTxt , nTamMax )

// ------------------------------------
	local aRet := {}
	local cRet := ''
	local nI   := 0
	local nK   := 0
	local nPos := 0
// ------------------------------------

	if len( cTxt)  > nTamMax

		for nI := 1 to len( cTxt )

			if ( len( cRet + substr( cTxt , nI , 1 ) ) <= nTamMax )
				cRet += substr( cTxt , nI , 1 )
			else
				if !empty( cRet )
					nPos := ( len( cRet ) - rat( ' ' , cRet ) )
					cRet := left( cRet , len( cRet ) - nPos )
					for nK := 1 to nPos
						nI--
					next nK
				endif
				aadd( aRet , cJustifica( cRet , nTamMax ) )
				cRet := substr( cTxt , nI , 1 )
			endif
		next nI
	else
		aadd( aRet , cTxt )
	endif

	if !empty( cRet )
		aadd( aRet , cRet )
	endif

return aRet

// +--------------------------------------------------------------------------+
// | Funcao : cJustifica                                                      |
// +--------------------------------------------------------------------------+

static function cJustifica( cTexto , nLimite )

// ------------------------------------
	local cRet      := rtrim( cTexto )
	local lContinua := .T.
	local nTamAnt   := 0
	local nI        := 1
	local lInicio   := .T.
// ------------------------------------

	if empty( cTexto )
		lContinua := .F.
		cRet      := space( nLimite )
	endif

	do while lContinua

		nTamAnt := len( cTexto )

		for nI := 1 to len( cTexto )

			if ( len( cTexto ) > nLimite )
				exit
			endif

			if lInicio .AND. ;
					( substr( cTexto , nI , 1 ) <> ' ' )
				lInicio := .F.
			endif

			if !lInicio .AND. ;
					( substr( cTexto , nI , 1 ) == ' ' )
				cTexto := stuff( cTexto , nI , 1 , space( 2 ) )
				nI++
			endif

			if ( nTamAnt == len(cTexto) ) .OR. ;
					( len( cTexto ) > nLimite )
				lContinua := .F.
			else
				cRet := cTexto
			endif

		next nI

	enddo

return cRet

// +--------------------------------------------------------------------------+
// | Funcao : cAlinDir                                                        |
// +--------------------------------------------------------------------------+

static function cAlinDir( cMsg , nColMax )
	cMsg := space( nColMax - len( cMsg ) - 1 ) + cMsg
return cMsg

// +--------------------------------------------------------------------------+
// | Funcao : cExtenPer                                                       |
// +--------------------------------------------------------------------------+

static function cExtenPer( nVlr )

// ------------------------------------
    local nInteiro  := 0
    local nDecimais := 0
    local cDescr    := ''
    local nCasas    := rat( '.' , cvaltochar( nVlr ) ) - 1
// ------------------------------------
    nCasas    := if( nCasas < 0 , 0 , nCasas )
	nDecimais := nVlr - noround( nVlr , 0 )
	nInteiro  := nVlr - nDecimais
	cDescr    := capital( lower( alltrim( extenso( nInteiro , .T. ,,, '1' , .T. ) ) ) )
// ------------------------------------
	if nDecimais > 0
        cDescr += ' vírgula ' + capital( lower( alltrim( extenso( nDecimais * ( 10 ^ nCasas ) , .T. ,,, '1' , .T. ) ) ) )
    endif
// ------------------------------------

return cDescr

// +--------------------------------------------------------------------------+
// | Funcao    : InaIntPF()       | Gustavo Thees                | 27/07/2022 |
// +--------------------------------------------------------------------------+
// | Descricao : Impressao de carta de inadimplencia.                         |
// |             Integral. Pessoa Física.                                     |
// +--------------------------------------------------------------------------+

user function InaIntPF( aCarta , nCont , dDatRef )

// ------------------------------------
    local _nZ  := 0
	local cDia := substr( dtoc(dDataBase) , 1 , 2 )
	local cMes := substr( dtoc(dDataBase) , 4 , 2 )
	local cAno := substr( dtoc(dDataBase) , 7 , 4 )
	local lPar := .F.
// ------------------------------------
    do case
       case cMes == '01'
	        cMes := 'janeiro'
       case cMes == '02'
	        cMes := 'fevereiro'
       case cMes == '03'
	        cMes := 'março'
       case cMes == '04'
	        cMes := 'abril'
       case cMes == '05'
	        cMes := 'maio'
       case cMes == '06'
	        cMes := 'junho'
       case cMes == '07'
	        cMes := 'julho'
       case cMes == '08'
	        cMes := 'agosto'
       case cMes == '09'
	        cMes := 'setembro'
       case cMes == '10'
	        cMes := 'outubro'
       case cMes == '11'
	        cMes := 'novembro'
       case cMes == '12'
	        cMes := 'dezembro'
    endcase
// ------------------------------------
    _aFat := separa( strtran(alltrim( aCarta[nCont,11] ),chr(13),"") , '-' , .T., )
	
    for _nz := 1 to len( _aFat )
        _aFat[_nz] := { substr( alltrim( _aFat[_nz] ) , 4 , 4 ) + ;
                        substr( alltrim( _aFat[_nz] ) , 1 , 2 ) , alltrim( _aFat[_nz] ) }
    next _nz
    _aFat[_nz-1] := { '999999' , '' }
    _aFat        := asort( _aFat ,,, { | x,y | x[1] < y[1] } )
// ------------------------------------

// ------------------------------------
//  [ Logo da operadora ]
// ------------------------------------
    oPrn:SayBitmap( 050 , 330 , cLogoCli , 400 , 400 )
// ------------------------------------
//  [ Cabecalho ]
// ------------------------------------
	oPrn:Say ( 0180 , 1210 , 'Rio de Janeiro, ' + cDia + ' de ' + cMes + ' de ' + Iif(Len(cAno)=2,"20"+cAno,cAno) + '.' , oFont5 , 100 )
    oPrn:Say ( 0675 , 1050 , 'NOTIFICAÇÃO'                                         , oFont7 , 100 )
    
// ------------------------------------
//  [ Dados do cliente... ]
// ------------------------------------
    oPrn:Say ( 0430 , 0330 ,          aCarta[nCont,1]   , oFont5 , 100 ) // NOME CLIENTE
    oPrn:Say ( 0460 , 0330 ,          aCarta[nCont,2]   , oFont5 , 100 ) // LOGRADOURO + NRO + COMPLEMENTO
    oPrn:Say ( 0490 , 0330 , alltrim( aCarta[nCont,3] ) + ;
                     ' - ' + alltrim( aCarta[nCont,4] ) + ;
                     ' - ' + alltrim( aCarta[nCont,5] ) , oFont5 , 100 ) // BAIRRO + CIDADE + ESTADO
    oPrn:Say ( 0520 , 0330 ,          aCarta[nCont,6]   , oFont5 , 100 ) // CEP
// ------------------------------------
//  [ Inicio da impressao do texto da carta... ]
// ------------------------------------
    nLin := 700
// ------------------------------------
//    oPrn:Line( Eval( bLin , nLin , 1 ) , nPasso , nLin , 2400 )
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Prezado Cliente, "                                                      , oFont5 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Reportamo-nos a V.Sa. para informar que verificamos em nossos registros o débito " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "no valor de R$ " + alltrim( transform( aCarta[nCont,7] , cMask102 )) + ;
	                                            " referente à(s) competência(s):"                                                   , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , " "                                                                                 , oFont6 , 100 )
// ------------------------------------

    If len( _aFat ) < 20 // Se for maior que 20 imprime em três colunas		
		for _nz := 1 to len( _aFat )
			if _nz != len( _aFat )
				if !lPar
					oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					lpar := .T.
				else
					oPrn:Say ( Eval( bLin , nLin , 0 ) , 1060 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					lpar := .F.
				endif
			endif
		next _nz
	Else
		for _nz := 1 to len( _aFat )
			if _nz != len( _aFat )
				if Mod(_nz,3) = 1
					oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					lpar := .T.
				elseif Mod(_nz,3) = 2
					oPrn:Say ( Eval( bLin , nLin , 0 ) , 0930 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					lpar := .F.
				Else
					oPrn:Say ( Eval( bLin , nLin , 0 ) , 1530 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
					lpar := .F.
				endif
			endif
		next _nz	
	EndIf	
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Pendências identificadas até " + dDatRef + "." , oFont6 , 100 )
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Com a intenção de continuarmos juntos e, sobretudo, para que possamos aprofundar " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "os  nossos laços de parceria,  pedimos que entre em contato  através  dos nossos " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "canais  de  atendimento  (abaixo)  onde buscaremos  a melhor maneira de evitar a " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "ruptura contratual e consequentemente o desligamento do plano. "                   , oFont6 , 100 )
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Aguardamos vosso contato até a data " + dtoc( aCarta[nCont,8] ) + ;
                                                ",  lembrando que a não quitação até "                                              , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "esta data poderá implicar na suspensão dos atendimentos."                          , oFont6 , 100 )
// ------------------------------------
    
	oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Matrícula: "+ aCarta[nCont,12]                                                     , oFont8 , 100 )
	
	
	
	
	If len( _aFat ) > 37 //Quebra de página caso ultrapasse o limite de parcelas
		
		oPrn:EndPage() //Finaliza Impressao da pagina 
		oPrn:StartPage() //Inicializa uma nova impressão
		// ------------------------------------
		//  [ Logo da operadora ]
		// ------------------------------------
			oPrn:SayBitmap( 050 , 330 , cLogoCli , 400 , 400 )
		// ------------------------------------
		//  [ Cabecalho ]
		// ------------------------------------
			oPrn:Say ( 0180 , 1210 , 'Rio de Janeiro, ' + cDia + ' de ' + cMes + ' de ' + Iif(Len(cAno)=2,"20"+cAno,cAno) + '.' , oFont5 , 100 )
			oPrn:Say ( 0675 , 1050 , 'NOTIFICAÇÃO'                                         , oFont7 , 100 )
		  nLin := 700
				
	Endif

		oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "ATENÇÃO:"                                                                          , oFont7 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Caso os apontamentos mencionados estejam quitados na data do comunicado, pedimos " , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "desconsiderar  e nos contatar  através  de nossos canais de atendimento (abaixo) " , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "para  nos  enviar  o comprovante  e  podermos  providenciar a  devida  baixa  de " , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "pendência em nosso sistema. "                                                      , oFont6 , 100 )
	// ------------------------------------
		oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Canais de atendimento:"                                                            , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Telefone: (21) 3233-8888"                                                          , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Whatsapp: (21) 3233-8888"                                                          , oFont6 , 100 )
	// ------------------------------------
		oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Atenciosamente,"                                                                   , oFont6 , 100 )
	// ------------------------------------
		oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Gerência Financeira"                                                               , oFont6 , 100 )
		oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Grupo CABERJ"                                                                      , oFont6 , 100 )
	// ------------------------------------
	
return


// +--------------------------------------------------------------------------+
// | Funcao    : InaIntPJ()       | Gustavo Thees                | 27/07/2022 |
// +--------------------------------------------------------------------------+
// | Descricao : Impressao de carta de inadimplencia.                         |
// |             Integral. Pessoa Física.                                     |
// +--------------------------------------------------------------------------+

user function InaIntPJ( aCarta , nCont , dDatRef )

// ------------------------------------
    local _nZ  := 0
	local cDia := substr( dtoc(dDataBase) , 1 , 2 )
	local cMes := substr( dtoc(dDataBase) , 4 , 2 )
	local cAno := substr( dtoc(dDataBase) , 7 , 4 )
	local lPar := .F.
// ------------------------------------
    do case
       case cMes == '01'
	        cMes := 'janeiro'
       case cMes == '02'
	        cMes := 'fevereiro'
       case cMes == '03'
	        cMes := 'março'
       case cMes == '04'
	        cMes := 'abril'
       case cMes == '05'
	        cMes := 'maio'
       case cMes == '06'
	        cMes := 'junho'
       case cMes == '07'
	        cMes := 'julho'
       case cMes == '08'
	        cMes := 'agosto'
       case cMes == '09'
	        cMes := 'setembro'
       case cMes == '10'
	        cMes := 'outubro'
       case cMes == '11'
	        cMes := 'novembro'
       case cMes == '12'
	        cMes := 'dezembro'
    endcase
// ------------------------------------
    _aFat := separa( alltrim( aCarta[nCont,11] ) , '-' , .T. )
    for _nz := 1 to len( _aFat )
        _aFat[_nz] := { substr( alltrim( _aFat[_nz] ) , 5 , 4 ) + ;
                        substr( alltrim( _aFat[_nz] ) , 1 , 3 ) , alltrim( _aFat[_nz] ) }
    next _nz
    _aFat[_nz-1] := { '999999' , '' }
    _aFat        := asort( _aFat ,,, { | x,y | x[1] < y[1] } )
// ------------------------------------

// ------------------------------------
//  [ Logo da operadora ]
// ------------------------------------
    oPrn:SayBitmap( 050 , 330 , cLogoCli , 400 , 400 )
// ------------------------------------
//  [ Cabecalho ]
// ------------------------------------
	oPrn:Say ( 0180 , 1210 , 'Rio de Janeiro, ' + cDia + ' de ' + cMes + ' de ' + Iif(Len(cAno)=2,"20"+cAno,cAno)  + '.' , oFont5 , 100 )
    oPrn:Say ( 0675 , 1050 , 'NOTIFICAÇÃO'                                         , oFont7 , 100 )
    
// ------------------------------------
//  [ Dados do cliente... ]
// ------------------------------------
    oPrn:Say ( 0430 , 0330 ,          aCarta[nCont,1]   , oFont5 , 100 ) // NOME CLIENTE
    oPrn:Say ( 0460 , 0330 ,          aCarta[nCont,2]   , oFont5 , 100 ) // LOGRADOURO + NRO + COMPLEMENTO
    oPrn:Say ( 0490 , 0330 , alltrim( aCarta[nCont,3] ) + ;
                     ' - ' + alltrim( aCarta[nCont,4] ) + ;
                     ' - ' + alltrim( aCarta[nCont,5] ) , oFont5 , 100 ) // BAIRRO + CIDADE + ESTADO
    oPrn:Say ( 0520 , 0330 ,          aCarta[nCont,6]   , oFont5 , 100 ) // CEP
// ------------------------------------
//  [ Inicio da impressao do texto da carta... ]
// ------------------------------------
    nLin := 700
// ------------------------------------
//    oPrn:Line( Eval( bLin , nLin , 1 ) , nPasso , nLin , 2400 )
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Prezado Cliente, "                                                      , oFont5 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Reportamo-nos a V.Sa. para informar que verificamos em nossos registros o débito " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "no valor de R$ " + alltrim( transform( aCarta[nCont,7] , cMask102 )) + ;
	                                            " referente à(s) competência(s):"                                                   , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , " "                                                                                 , oFont6 , 100 )
// ------------------------------------
    for _nz := 1 to len( _aFat )
        if _nz != len( _aFat )
		    if !lPar
                oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
				lpar := .T.
			else
                oPrn:Say ( Eval( bLin , nLin , 0 ) , 1060 , alltrim(_aFat[_nz][2]) + "." , oFont6 , 150 )
				lpar := .F.
			endif
        endif
    next _nz
// ------------------------------------
    //oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Pendências identificadas até " + dDatRef + "." , oFont6 , 100 )

	oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Pedimos que os débitos sejam negociados e/ou quitados até "+dtoc( aCarta[nCont,8])+ " nos telefones" , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "abaixo para que possamos evitar a ruptura contratual. " , oFont6 , 100 )
    
/*/ ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "Com a intenção de continuarmos juntos e, sobretudo, para que possamos aprofundar " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "os  nossos laços de parceria,  pedimos que entre em contato  através  dos nossos " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "canais  de  atendimento  (abaixo)  onde buscaremos  a melhor maneira de evitar a " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "ruptura contratual e consequentemente o desligamento do plano. "                   , oFont6 , 100 )
  ------------------------------------*/
    oPrn:Say ( Eval( bLin , nLin , 2 ) , 0330 , "A não quitação até esta data implicará na inclusão do débito no Serviço de Proteção ao " , oFont6 , 100 )
	oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Crédito (SERASA). Em caso de cancelamento o pagamento posterior a data acima será  "    , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "tido como crédito para fins de acompensação dos eventuais valores em atraso e não "          , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "acarretará na reativação do contrato." 							                         , oFont6 , 100 )


// ------------------------------------
    
	//oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "  " , oFont8 , 100 )
	
	//oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "ATENÇÃO:"                                                                          , oFont7 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 2 ) 	, 0330 , "Caso os apontamentos mencionados estejam quitados na data do comunicado, pedimos "    , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "desconsiderar  encaminhando-nos comprovante para o e-mail financeiro2@caberj.com.br " , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "para  nos  enviar  o comprovante  e  podermos  providenciar a  devida  baixa  de "    , oFont6 , 100 )
    

// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Atenciosamente,"                                                                   , oFont6 , 100 )
// ------------------------------------
    oPrn:Say ( Eval( bLin , nLin , 3 ) , 0330 , "Gerência Financeira"                                                               , oFont6 , 100 )
    oPrn:Say ( Eval( bLin , nLin , 1 ) , 0330 , "Grupo CABERJ"                                                                      , oFont6 , 100 )
// ------------------------------------

	oPrn:Line(      Eval( bLin , nLin , 33 ) , nPasso , nLin     ,   2400       )

	oPrn:Say (  2800 , 450 , "Rua do ouvidor, 91 - Centro - Rio de Janeiro - CEP: 20040-031" , oFont9 , 100 )
	oPrn:Say (  2830 , 350 , "Telefone: (21)3233-8888 - www.caberj.com.br - faleconosco@caberj.com.br" , oFont9 , 100 )

return
