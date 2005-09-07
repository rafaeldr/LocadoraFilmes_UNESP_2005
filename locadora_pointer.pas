{Autor: Rafael Delalibera Rodrigues}
{Bacharelado em Ci�ncias da Computa��o - 1� Ano - 2� Semestre}
{Introdu��o � Computa��o 2 - Professor Carlos Fisher}
{Data: 7 de Setembro de 2005}
Program icc2_locadora2 ;
 uses crt;
 type ponteiro = ^cad; {Ponteiro para cadastro de clientes}
	 cad = record nome:string[60];      {Registro para Cadastro de clientes}
 			 cpf:integer;
 			 endereco: record cidade:string[60];
 			      	        estado:string[2];
 			  			   rua:string[60];
 			  			   numero:integer;
 			  			   complemento:string[30];
 			  			   bairro:string[30];
 			  			   cep:integer;
 						   end;
 	      	 data:integer;
 			 codigo:integer;
			 pont:integer;
                loca:integer;
			 n_loca:integer;
			 n_dev:integer;
			 prox:ponteiro;
			 end; 
	 ponteiro2 = ^film;  {Ponteiro para cadastro de filmes}
	 film = record nome:string[40]; {Registro para cadastro de filmes}
	 			codigo:integer;
	 			cliente:integer;
	 			prox:ponteiro2;
				end; 
 var inicio,novo,aux:ponteiro;    {Ponteiros para lista ligada de clientes}
 	inicio2,novo2,aux2:ponteiro2; {Ponteiros para lista ligada de filmes}
 	n_clientes:integer;  {N�mero de clientes cadastrados}
 	n_filmes:integer;    {N�mero de filmes cadastrados}
 	op:integer;      {Op��o para o menu principal}
 	ask:char;
 procedure novo_cli;   {Procedimento para cadastrar novos clientes}
 	var i:integer;
 	begin
 	new(novo);
 	write('Digite o nome do cliente: ');
	readln(novo^.nome);
 	write('CPF: ');
	readln(novo^.cpf);
     write('Cidade: ');
 	readln(novo^.endereco.cidade);
     write('Estado: ');
 	readln(novo^.endereco.estado);
     write('Rua: ');
 	readln(novo^.endereco.rua);
     write('N�mero: ');
 	readln(novo^.endereco.numero);
     write('Complemento: ');
 	readln(novo^.endereco.complemento);
     write('Bairro: ');
 	readln(novo^.endereco.bairro);
     write('CEP: ');
 	readln(novo^.endereco.cep);
     write('Data: ');
 	readln(novo^.data);
	novo^.pont:=0;
	novo^.n_loca:=0;
	novo^.n_dev:=0;
 	novo^.loca:=0;
 	novo^.prox:=nil;
 	n_clientes:=n_clientes+1;
 	novo^.codigo:=n_clientes;
	if inicio <> nil then
	 	begin
	     aux:=inicio;
	     while aux^.prox <> nil do aux:=aux^.prox;
	     aux^.prox:=novo;
	     end
	     else
	     inicio:=novo;
 	readln;
	clrscr;
	end;     
 procedure novo_filme;     {Procedimento para cadastrar novos filmes}
 	begin
 	new(novo2);
 	write('Digite o nome do filme: ');
	read(novo2^.nome);
	n_filmes:=n_filmes+1;
	novo2^.codigo:=n_filmes;
	novo2^.cliente:=0;
	novo2^.prox:=nil;
	if inicio2 <> nil then
	 	begin
	     aux2:=inicio2;
	     while aux2^.prox <> nil do aux2:=aux2^.prox;
	     aux2^.prox:=novo2;
	     end
	     else
	     inicio2:=novo2;
	readln;
	clrscr;
	end;  
 procedure busca_cliente;      {Procedimento para buscar por clientes cadastrados}
 	var n:string[60]; cod:integer; ask:integer;
	begin
 	writeln('Procurar Cliente:');
 	writeln('1 - Pelo C�digo');
 	writeln('2 - Pelo Nome');
	write('Digite o N�mero correspondente a sua escolha: ');
	if ask=1 then
 		begin
			write('Digite o codigo: ');
	     	readln(cod);
			if (cod<= n_clientes) and (cod>0) then
				begin
					aux:=inicio;
					while aux^.codigo<>cod do
						begin
						aux:=aux^.prox;
						end;
					write('Cliente: ',aux^.nome);
				end
			else write('C�digo n�o existente');
		end
		else 
		begin
		write('Digite o nome do cliente: ');
		readln(n);
		aux:=inicio;
		while (upcase(aux^.nome)<>upcase(n)) or (aux^.prox<>nil) do
			begin
			aux:=aux^.prox;
			end;		
		if aux^.prox=nil then write('Cliente n�o encontrado!')
		else writeln('C�digo: ', aux^.codigo);
		end;  {end do if ask1}
	readln;
	clrscr;
	end;  
  procedure busca_filme;         {Procedimento para buscar por filmes cadastrados}
 	var n:string[40]; cod:integer; ask:integer;
	begin
 	writeln('Procurar Filme:');
 	writeln('1 - Pelo C�digo');
 	writeln('2 - Pelo Nome');
	write('Digite o N�mero correspondente a sua escolha: ');
	if ask=1 then
 		begin
		write('Digite o codigo: ');
	     readln(cod);
		if (cod<= n_filmes) and (cod>0) then
			begin
				aux2:=inicio2;
				while aux2^.codigo<>cod do
					begin
					aux2:=aux2^.prox;
					end;
				writeln('Filme: ',aux2^.nome);
				if aux2^.cliente=0 then write('Dispon�vel para Empr�stimo')
				else write('Alugado!');
			end
		else write('C�digo n�o existente');
		end
	else 
		begin
		write('Digite o nome do filme: ');
		readln(n);
		aux2:=inicio2;
		while (upcase(aux2^.nome)<>upcase(n)) or (aux2^.prox<>nil) do
			begin
			aux2:=aux2^.prox;
			end;		
		if aux2^.prox=nil then write('Filme n�o encontrado!')
		else 
			begin
			writeln('C�digo: ', aux2^.codigo);
			if aux2^.cliente=0 then write('Dispon�vel para Empr�stimo')
				else write('Alugado!');
			end;
		end;
	readln;
	clrscr;
	end;
 procedure emp;     {Procedimento para empr�stimo de filmes}
 	var filme,cliente:integer;
	begin
 	if (n_clientes=0) or (n_filmes=0) then write('N�o h� filmes ou clientes cadastrados')
	else
		begin
		aux:=inicio;
		aux2:=inicio2;
		write('Digite o c�digo do filme: ');
		readln(filme);
		write('Digite o c�digo do cliente: ');
		readln(cliente);
		if (cliente>0) or (cliente<=n_clientes) or (filme>0) or (filme<=n_filmes)
		then	begin
		     while aux^.codigo<>cliente do
				begin
				aux:=aux^.prox;
				end;
		     if aux^.n_loca<>0 then write('Confiabilidade: ',(aux^.n_dev/aux^.n_loca)*100,'%');
			while aux2^.codigo<>filme do
		     	begin
		     	aux2:=aux2^.prox;
				end;
			aux2^.cliente:=cliente;
			aux^.loca:=filme;
			aux^.n_loca:=aux^.n_loca+1;
			end
		else write('C�digo do cliente e/ou filme incorreto(s)!');
		end;
	readln;
	clrscr;
	end;
 procedure dev;    {Procedimento para devolu��o de filmes}
 	var filme:integer;
	begin
 	if (n_clientes=0) or (n_filmes=0) then write('N�o h� filmes ou clientes cadastrados')
	else
		begin
		aux:=inicio;
		aux2:=inicio2;
		write('Digite o c�digo do filme: ');
		readln(filme);
		if (filme>0) or (filme<=n_filmes)
		then	begin
		     while aux2^.codigo<>filme do
				aux2:=aux2^.prox;
		     if aux2^.cliente=0 then write('Este Filme n�o est� alugado!')
		     else
		     	begin
		     	while aux^.codigo<>aux2^.cliente do 
				aux:=aux^.prox;
				aux^.n_dev:=aux^.n_dev+1;
				aux^.loca:=0;
				aux2^.cliente:=0;
				end;
			end
		else write('C�digo do cliente e/ou filme incorreto(s)!');
		end;
	readln;
	clrscr;
	end;
 Begin   {Inicio do Programa Principal}
 clrscr;
 n_clientes:=0;
 n_filmes:=0;
 inicio:=nil;
 inicio2:=nil;
 while upcase(ask)<>'N' do
 begin
 writeln('Menu Principal: ');
 writeln('1 - Cadastrar Novo Cliente');
 writeln('2 - Cadastrar Novo Filme');
 writeln('3 - Buscar por Cliente');
 writeln('4 - Buscar por Filme');
 writeln('5 - Empr�stimo de Filme');
 writeln('6 - Devolu��o de Filme');
 writeln('7 - Sair do Programa');
 write('Digite a op��o desejada: ');
 read(op);
 case op of
 1: novo_cli;
 2: novo_filme;
 3: busca_cliente;
 4: busca_filme;
 5: emp;
 6: dev;
 7: ask:='N';
 end;
 end;{end do while}
 readln; 
 End.   {Fim do Programa Principal}
 {Copilador: Pascal ZIM! Vers�o 4.07}
