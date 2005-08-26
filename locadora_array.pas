{Programador: Rafael Delalibera Rodrigues - UNESP - Campus Rio Claro}
{Bacharelado em Ciências da Comutação - 1° Ano Integral 2005}
{Introdução à Computação 2 - Professor Carlos Fischer}
 
Program icc2_locadora;
 uses crt;
 type cadastro= record nome:string[60];	{Registro para os dados dos clientes}
						cpf:integer;
						codigo:integer;
						fone:integer;
						endereco:record cidade:string[30];
										estado:string[2];
										rua:string[30];
										numero:integer;
                                                                                complemento:string[10];
										bairro:string[25];
										cep:integer;
										end;
						data:integer;
						pont:real;		{Variável para controle da confiabilidade do cliente}
						loca:array[1..5] of integer; {Filmes Locados}
						n_loca:integer;	{Número de filmes ainda não devolvidos pelo cliente}
						n_dev:integer;	{Número total de devolução}
						n_total:integer; {Número total de filmes retirados}
						end;  
		cad= record nome:string[40];	{Registro para os dados dos filmes}
					codigo :integer;	{Código do cliente para o qual o filme está emprestado}
					disp:integer;		{Disponibilidade}
					cliente:integer;					
					ret,dev :record dd:integer;
										mm:integer;
										aaaa:integer;
										end;
					end ;
 var cliente:array[1..300] of cadastro;
     filme:array[1..300] of cad;
     n_clientes, n_film,op:integer ; {Num. de clientes cadastrados; Num. filmes cadastrados; Opção}
     ask2:char;
  
 procedure clear_var;	{Limpa os valores de memória das variáveis}
	var i,j:integer;
	begin
	for i:=1 to 300 do
		begin
		cliente[i].codigo:=999;	{999 é utilizado como parâmetro}
		cliente[i].pont:=0;
		cliente[i].n_loca:=0;
		cliente[i].n_total:=0;
		cliente[i].n_dev:=0;
		for j:=1 to 5 do cliente[i].loca[j]:=999;
		filme[i].codigo:=999;
		filme[i].ret.dd:=99;
		filme[i].dev.mm:=99;
		filme[i].dev.dd:=99;
		filme[i].cliente:=999;
		filme[i].disp:=999;
		end;
	end;
 procedure new_cad;		{Procedimento para cadastrar os clientes}
	var i:integer;
		ask:char;
	begin
	ask:='k';
	while upcase(ask)<>'N ' do
		begin
		clrscr;
		n_clientes:=n_clientes+1;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Cadastrar  Novo Cliente @@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		write('Código: ',n_clientes);
		cliente[n_clientes].codigo:=n_clientes;
		gotoxy(5,7);
		write('Nome : ');
		read(cliente[n_clientes].nome);
		gotoxy(5,8);
		write('CPF : ');
		read(cliente[n_clientes].cpf);
		gotoxy(5,9);
		write('Telefone: ');
		read(cliente[n_clientes].fone);
			gotoxy(5,10);
			write('Endereço');
			gotoxy(15,10);
			write('Cidade : ');
			read(cliente[n_clientes].endereco.cidade);
			gotoxy(15,11);
			write('Estado: ');
			read(cliente[n_clientes].endereco.estado);
			gotoxy(15,12);
			write('Rua: ');
			read(cliente[n_clientes].endereco.rua);
			gotoxy(15,13);
			write('Número: ');
			read(cliente[n_clientes].endereco.numero);
			gotoxy(15,14);
			write('Complemento: ');
			read(cliente[n_clientes].endereco.complemento);
			gotoxy(15,15);
			write('Bairro: ');
			read(cliente[n_clientes].endereco.bairro);
			gotoxy(15,16);
			write('CEP: ');
			read(cliente[n_clientes].endereco.cep);
		gotoxy(5,17);
		write('Data de Cadastramento:(DDMMAA) ');
		readln(cliente[n_clientes].data);
		cliente[n_clientes].pont:=999;
		for i:=1 to 5 do
			cliente[n_clientes].loca[i]:=999;
		cliente[n_clientes].n_loca:=0;
		gotoxy(10,20);
		write('Deseja cadastrar mais um cliente? (S/N)');
		read(ask);
		clrscr;
		end;
	end;

 procedure new_film;	{Procedimento para cadastrar os filmes}
	var ask:char;
	begin
	ask:='k';
	while upcase(ask)<>'N' do
		begin
		clrscr;
		n_film:=n_film+1;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Cadastrar Novo Filme @@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		filme[n_film].codigo:=n_film;
		gotoxy(5,5);
		write('Código: ',filme[n_film].codigo);
		gotoxy(5,7);
		write('Nome: ');
		read(filme[n_film].nome);
		filme[n_film].disp:=1;
		gotoxy(10,20);
		write('Deseja cadastrar mais um filme? (S/N)');
		read(ask);
		clrscr;
		end;
	end;
 procedure ret_film;	{Procedimento para efetuar empréstimos}
	var k,code,code2:integer;	{code: código do filme; code2 : código do cliente}
		ask:char;
	begin
	clrscr;
	ask:= 'k';
	if (n_film=0) or (n_clientes=0) then	{Verifica se há filmes ou clientes cadastrados}
		begin
		gotoxy(20,10);
		write('Não há filmes ou clientes cadastrados!');
		gotoxy(20 ,12);
		ask:='N';
		write('Pressine a tecla ENTER para voltar ao Menu');
		readln;
		end;
	while (upcase(ask)<>'N') and (n_film>0) do
		begin
		clrscr;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Empréstimo de Filmes @@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		write('Digite o código do filme: ');
		repeat
			gotoxy(31,5);
			read(code);
			if (code<0) or (code>n_film) then	{Verifica se o código refere-se há algum filme cadastrado}
				begin
				gotoxy(10,8);
				write('O código digitado não corresponde a nenhum filme cadastrado!');
				gotoxy(10,9);
				write( 'Digite o código novamente!!!');
				end;
		until ((0)<(code)) and ((code)<=(n_film));
		gotoxy(1,8);
		write('                                                                                ');
		gotoxy(1,9);
		write('                                                                                ');
		gotoxy(5,7);
		write('Filme: ',filme[code].nome);
		gotoxy(5,8);
		write('Digite o código do cliente: ');
		repeat
			gotoxy(33,8);
			read(code2);
			if (code2<0) or (code2>n_clientes) then	{Verifica se o código refere-se há algum cliente cadastrado}
				begin
				gotoxy(10,10);
				write('O código digitado não corresponde a nenhum cliente cadastrado!');
				gotoxy(10,11);
				write('Digite o código novamente!!!');
				end;
		until ((0)<(code2)) and ((code2)<=(n_clientes));
		gotoxy(1,10);
		write('                                                                                ');
		gotoxy(1,11);
		write('                                                                                ');
		gotoxy(5,9);
		write('Cliente: ',cliente[code2].nome,'	Confiabilidade: ',cliente[code2].pont,'% ');
		gotoxy(5,10);
		write('Número de filmes alugados: ',cliente[code2].n_loca);
		if cliente[code2].n_loca<>5 then
			begin
			case cliente[code2].n_loca of
				0: cliente[code2].loca[1]:=code;
				1: cliente[code2].loca[2]:=code;
				2: cliente[code2].loca[3]:=code;
				3: cliente[code2].loca[4]:=code;
				4: cliente[code2].loca[5]:=code;
				end;
			k:=0;
			filme[code].cliente:=code2;
			while k=0 do
				begin
				gotoxy(5,11);
				write('Digite a data de retirada: DD: ');
				repeat
					gotoxy(36,11);
					read(filme[code].ret.dd);
				until (filme[code].ret.dd>0) and (filme[code].ret.dd<32);
				gotoxy(32,12);
				write('MM: ');
				repeat
					gotoxy(36,12);
					read(filme[code].ret.mm);
				until (filme[code].ret.mm>0) and (filme[code].ret.mm<13);
				gotoxy(32,13);
				write('AAAA: ');
				repeat
					gotoxy(38,13);
					read(filme[code].ret.aaaa);
				until(filme[code].ret.aaaa>0) and (filme[code].ret.aaaa<10000);
				filme[code].dev.aaaa:=filme[code].ret.aaaa;
				filme[code].dev.dd:=filme[code].ret.dd+2;
				if (filme[code].ret.dd=30) or (filme[code].ret.dd=29) then	{Verificação das datas de retirada e devolução}
					begin
					case filme[code].ret.mm of 4,6,9,11:
						begin
						filme[code].dev.mm:=filme[code].ret.mm+1;
						filme[code].dev.dd:=2;
						end;
					end;
					if filme[code].ret.dd=29 then filme[code].dev.dd:=1;
					end;
				if (filme[code].ret.dd=31) or (filme[code].ret.dd=30) then
					begin
					case filme[code].ret.mm of 1,3,5,7,8,10:
						begin
						filme[code].dev.mm:=filme[code].ret.mm+1;
						filme[code].dev.dd:=2;
						end;
						12:
							begin
							filme[code].dev.mm:=1;
							filme[code].dev.dd:=2;
							filme[code].dev.aaaa:=filme[code].ret.aaaa+1;
							end;
					end;
					if filme[code].ret.dd=30 then filme[code].dev.dd:=1;
					end;
				if (((filme[code].ret.aaaa mod 4)=0) and (filme[code].ret.mm=2)) and ((filme[code].ret.dd>27) and (filme[code].ret.dd<30)) then
					begin
					filme[code].dev.mm:=3;
					case filme[code].ret.dd of
						28: filme[code].dev.dd:=1;
						29: filme[code].dev.dd:=2;
					end;
					end;
				if ((filme[code].ret.aaaa mod 4)<>0) and (filme[code].ret.mm=2) and ((filme[code].ret.dd)>26) and ((filme[code].ret.dd)<29) then
					begin
					filme[code].dev.mm:=3;
					case filme[code].ret.dd of
						27: filme[code].dev.dd:=1;
						28: filme[code].dev.dd:=2;
					end;
					end;
				if (filme[code].ret.mm=2) and (filme[code].ret.dd<27) then filme[code].dev.mm:=2;
				if (filme[code].ret.mm<>2) and (filme[code].ret.dd<29) then filme[code].dev.mm:=filme[code].ret.mm;
				if (filme[code].ret.mm<>2) and (filme[code].ret.dd<30) then
					case filme[code].ret.mm of 1,3,5,7,8,10,12:
					filme[code].dev.mm:=filme[code].ret.mm;
					end;
				if filme[code].dev.mm=9 then
					begin
					gotoxy(1,11);
					write('                                                                                ');
					gotoxy(1,12);
					write('                                                                                ');
					gotoxy(1,13);
					write('                                                                                ');
					gotoxy(20,21);
					write('A data digitada é inválida!');
					gotoxy(20,22);
					write('Pressine a tecla ENTER para continuar!');
					readln;
					end
				else k:=1;
					end;
				gotoxy(5,14);
				write('Data de devolução: ',filme[code].dev.dd,'/',filme[code].dev.mm,'/ ',filme[code].dev.aaaa);
				gotoxy(5,16);
				write('Empréstimo efetuado com sucesso!');
				cliente[code2].n_loca:=cliente[code2].n_loca+1;	{Atualizando os dados do programa}
				cliente[code2].loca[cliente[code2].n_loca]:=code;
				cliente[code2].n_total:=cliente[code2].n_total+1;
				filme[code].disp:=0;
				gotoxy(10,20);
				write('Deseja registrar o empréstimo de mais filmes? (S/N)');
				read(ask);
				clrscr;
			end	{end do then}
		else
			begin
			gotoxy(20,20);
			write('O cliente já alugou o número máximo de filmes permitido!');
			ask:='N';
			gotoxy(20,21);
			write('Pressine a tecla ENTER para voltar ao Menu');
			end; {end do else e do then! }
		end;	{end do while}
		clrscr;
		end;	{end do procedimento}
		
 procedure dev_film;	{Procedimento para devolução de filmes}
	var i,j,d,codec,codef:integer;
		ask:char;
	begin
	ask:='k';
	clrscr;
	j:=0;
	for i:=1 to 300 do
		if filme[i].cliente<>999 then j:=j+1; {Verifica se há filmes emprestados a algum cliente}
	if j=300 then
		begin
		gotoxy(20,14);
		write('Não há filmes emprestados!');
		gotoxy(20,16);
		write('Pressione a tecla ENTER para continuar!');
		readln;
		end;
	if (n_film=0) or (n_clientes=0) then	{Verifica se há filmes ou cliente cadastrados}
		begin
		gotoxy(20,10);
		write('Não há filmes ou clientes cadastrados!');
		gotoxy(20,12);
		ask:='N';
		write('Pressine a tecla ENTER para voltar ao Menu');
		readln;
		end;
	while upcase(ask)<>'N' do
		begin
		clrscr;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Devolução de Filmes @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		write('Efetuar a devolução a partir: ');
		gotoxy(35,6);
		write('l - Do código do cliente .');
		gotoxy(35,7);
		write('2 - Do código do filme.');
		gotoxy(5,10);
		write('Digite a opção desejada(l/2): ');
		i:=0;
		repeat
			gotoxy(36,10);
			read(i);
		until (i=1) or (i=2);
		gotoxy(1,5);
		write('                                                                                ');
		gotoxy(1,6);
		write('                                                                                ');
		gotoxy(1,7);
		write('                                                                                ');
		gotoxy(1,10);
		write('                                                                                ');
		if i=1 then
			begin
			gotoxy(5,5);
			write('Diqite o código do cliente: ');
			d:=0;
			repeat
				gotoxy(33,5);
				read(codec);
				if (codec<0) or (codec>n_clientes) {Verifica se o código digitado corresponde a algum cliente cadastrado}
					then
						begin
						gotoxy(20,20);
						write('Código de cliente inválido!');
						gotoxy(20,21);
						write('Pressione a tecla ENTER para continuar!');
						end
					else
						if cliente[codec].n_loca=0	{Verifica se o cliente tem filmes alugados} 
							then
								begin
								gotoxy(20,20);
								write('Esse cliente não possui nenhum filme alugado!');
								gotoxy(20,21);
								write(' Pressione a tecla ENTER para end para continuar!');
								end
							else
								d:=1;
			until d=1;
			gotoxy(1,20);
			write('                                                                                ');
			gotoxy(1,21);
			write('                                                                                ');
			gotoxy(5,7);
			write('Cliente: ',cliente[codec].nome);
			gotoxy(5,8);
			write('Filmes Alugados: 	Nome	/	Código	/	Data Devolução');
			d:=cliente[codec].n_loca;
			for j:=1 to d do
				begin
				gotoxy(5,6+j);
				write(j,' - ',filme[cliente[codec].loca[j]].nome,' Cod: ',
						cliente[codec].loca[j],' ',filme[cliente[codec].loca[j]].dev.dd,'/',
						filme[cliente[codec].loca[j]].dev.mm,'/',filme[cliente[codec].loca[j]].dev.aaaa);
				end;
			gotoxy(5,13);
			write('Digite o código do filme devolvido: ');
			d:=0;
			repeat
				gotoxy(41,13);
				read(codef);
				if (codef<>cliente[codec].loca[1]) and
					(codef<>cliente[codec].loca[2]) and (codef<>cliente[codec].loca[3]) and
					(codef<>cliente[codec].loca[4]) and (codef<>cliente[codec].loca[5])
					then
						begin
						gotoxy(20,20);
						write('O código digitado não corresponde a nenhum filme deste cliente!');
						gotoxy(20,21);
						write('Pressione a tecla ENTER para continuar!');
						end
					else d :=1;
			until d=1;
			gotoxy(1,20);
			write('                                                                                ');
			gotoxy(1,21);
			write('                                                                                ');
			for j:=1 to 5 do
				if codef=cliente[codec].loca[j] then d:=j;
			case cliente[codec].n_loca of	{Apaga o código do filme devolvido}
				1: cliente[codec].loca[d]:=999;	{Ordena a lista de filmes alugados pelo cliente}
				2:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[2];
					cliente[codec].loca[2]:=999;
					end;
				3:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[3];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[3];
					cliente[codec].loca[3]:=999;
					end;
				4:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[4];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[4];
					if d=3 then
						cliente[codec].loca[3]:=cliente[codec].loca[4];
					cliente[codec].loca[4]:=999;
					end;
				5:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[5];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[5];
					if d=3 then
						cliente[codec].loca[3]:=cliente[codec].loca[5];
					if d=4 then
						cliente[codec].loca[4]:=cliente[codec].loca[5];
					cliente[codec].loca[5]:=999;
					end;
				end;
			cliente[codec].n_loca:=cliente[codec].n_loca-1;	{Atualiza os dados do programa}
			cliente[codec].n_dev:=cliente[codec].n_dev+1;
			cliente[codec].pont:=((cliente[codec].n_dev)/(cliente[codec].n_total))*100;
			filme[codef].dev.mm:=99;
			filme[codef].dev.dd:=99;
			filme[codef].ret.dd:=99;
			filme[codef].disp:=1;
			filme[codef].cliente:=999;
			end;
		if i=2 then
			begin
			gotoxy(5,5);
			write ('Digite o código do filme: ');
			d:=0;
			repeat
				gotoxy(31,5);
				read(codef);
				if (codef<0) or (codef>n_film)
					then
						begin
						gotoxy(20,20);
						write('Código do filme inválido!');
						gotoxy(20,21);
						write('Pressione a tecla ENTER para continuar!');
						end
					else
						d:=1;
			until d=1;
			gotoxy(1,20);
			write('                                                                                ');
			gotoxy(1,21);
			write('                                                                                ');
			gotoxy(5,7);
			write('Filme: ',filme[codef].nome,' Cod: ',codef,' Devolução: ',
				filme[codef].dev.dd,'/',filme[codef].dev.mm,'/',filme[codef].dev.aaaa);
			codec:=filme[codef].cliente;
			gotoxy(5,9);
			write('Cliente: ',cliente[codec].nome,' Cod: ',codec);
			codec:=filme[codef].cliente;
			for j:=1 to 5 do
				if cliente[codec].loca[j]=codef then d:=j;
			case cliente[codec].n_loca of	{Apaga o código do filme devolvido}
				1: cliente[codec].loca[d]:=999; {Ordena a lista de filmes alugados pelo cliente}
				2:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[2];
					cliente[codec].loca[2]:=999;
					end;
				3:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[3];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[3];
					cliente[codec].loca[3]:=999;
					end;
				4:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[4];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[4];
					if d=3 then
						cliente[codec].loca[3]:=cliente[codec].loca[4];
					cliente[codec].loca[4]:=999;
					end;
				5:	begin
					if d=1 then
						cliente[codec].loca[1]:=cliente[codec].loca[5];
					if d=2 then
						cliente[codec].loca[2]:=cliente[codec].loca[5];
					if d=3 then
						cliente[codec].loca[3]:=cliente[codec].loca[5];
					if d=4 then
						cliente[codec].loca[4]:=cliente[codec].loca[5];
					cliente[codec].loca[5]:=999;
					end;
				end;
			cliente[codec].n_loca:=cliente[codec].n_loca-1;	{Atualiza os dados do programa}
			cliente[codec].n_dev:=cliente[codec].n_dev+1;
			cliente[codec].pont:=cliente[codec].n_dev/cliente[codec].n_total;
			filme[codef].dev.mm:=99;
			filme[codef].dev.dd:=99;
			filme[codef].ret.dd:=99;
			filme[codef].disp:=1;
			filme[codef].cliente:=999;
			end;
		gotoxy(10,18);
		write('Devolução efetuada com sucesso!');
		gotoxy(10,20);
		write('Deseja registrar a devolução de mais filmes? (S/N)');
		read(ask);
		clrscr;
		end;
	clrscr;
	end;

 procedure busca_cli;	{Procedimento para buscar clientes}
	var ask:char;
		b:string[60];
		i,j,k,h,num:integer;
	begin
	clrscr;
	ask:='k';
	if n_clientes=0 then	{Verifica se há clientes cadastrados}
		begin
		gotoxy(20,10);
		write('Não há clientes cadastrados!');
		ask:='N';
		gotoxy(20,12);
		write('Pressine a tecla ENTER para voltar ao Menu');
		readln;
		end;
	while upcase(ask)<>'N' do
		begin
		clrscr;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Busca por Clientes @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		for i:=1 to 60 do
			b[i]:='9';
		write('Digite uma palavra-chave: ');
		repeat
			gotoxy(31,5);
			read(b);
		until b[4]<>'9';
		j:=0;
		for i:=1 to 60 do
			if b[i]<>'9' then j:=j+1;
		gotoxy(1,6);
		for i:=1 to 300 do	{Efetua a busca de modo bruto}
			begin
			for h:=0 to 60-j do {Responsável por transladar a palavra-chave através do objeto da busca}
				begin
				num:=0;
				for k:=1 to j do	{Responsável por comparar a palavra-chave com o objeto da busca}
					begin
					if upcase(cliente[i].nome[k+h])=upcase(b[k])
						then num:=num+1;
					if num=j then writeln('Nome: ',cliente[i].nome,' Cod: ',i);
					end;
				end;
			end;
		gotoxy(10,20);
		write('Deseja procurar por mais clientes? (S/N)');
		read(ask);
		clrscr;
		end; {end do while}
	clrscr;
	end; {end do procedure}  
 
 procedure busca_film;	{Procedimento para buscar filmes}
	var ask:char;
		b:string[40];
		i,j,k,h,num:integer;
	begin
	clrscr;
	ask:='k';
	if n_film=0 then
		begin
		gotoxy(20,10);
		write('Não há filmes cadastrados!');
		ask:='N';
		gotoxy(20,12);
		write('Pressine a tecla ENTER para voltar ao Menu');
		readln;
		end;
	while upcase(ask)<>'N' do
		begin
		clrscr;
		gotoxy(1,1);
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Busca por Filmes @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		for i :=1 to 40 do
			b[i]:='9';
		write('Digite uma palavra chave: ');
		repeat
			gotoxy(31,5);
			read(b);
		until b[4]<>'9';
		j:=0;
		for i:=1 to 40 do
			if b[i]<>'9' then j:=j+1;
		gotoxy(1,6);
		for i:=1 to 300 do	{Efetua a busca de modo bruto}
			begin
			for h:=0 to 40-j do {Responsável por transladar a palavra-chave através do objeto da busca}
				begin
				num:=0;
				for k:=1 to j do	{Responsável por comparar a palavra-chave com o objeto da busca}
					begin
					if upcase(filme[i].nome[k+h])=upcase(b[k]) then
						num:=num+1;
					if num=j then
						begin
						write('Nome: ',filme[i].nome,'	Cod: ',i,' ');
						if filme[i].disp=1 then writeln('Disponivel: Sim')
							else writeln('Disponivel : Não');
						end;
					end;
				end;
			end;
		gotoxy(10,20);
		write('Deseja procurar por mais filmes? (S/N)');
		read(ask);
		clrscr;
		end; {end do while}
	clrscr;
	end; {end do procedure}

 Begin	{Inicio do Programa Principal}
	clrscr;
	n_film:=0;
	n_clientes:=0;
	clear_var;
	ask2:='k';
	while upcase(ask2)<>'N' do
		begin
		clrscr;
		gotoxy(1,1);	{Parte Gráfica do Menu de Escolhas}
	{1,1}write('################################################################################');
	{1,2}write('@@@@@@@@@@@@@@@@@@@@@@@@@@@ Menu Principal - Locadora @@@@@@@@@@@@@@@@@@@@@@@@@@');
	{1,3}write('################################################################################');
		gotoxy(5,5);
		write('l - Empréstimo de Filmes.');
		gotoxy(5,7);
		write('2 - Devolução de Filmes.');
		gotoxy(5,9);
		write('3 - Buscar por Filmes.');
		gotoxy(5,11);
		write('4 - Buscar por Clientes.');
		gotoxy(5,13);
		write( '5 - Cadastrar Novo Filme.');
		gotoxy(5,15);
		write('6 - Cadastrar Novo Cliente.');
		gotoxy(5,17);
		write('7 - Sair do Programa.');
		gotoxy(5,19);
		write('Digite o nuúmero da opção desejada(1..7): ');
		repeat
			gotoxy(46,19);
			read(op);
		until (op>0) and (op<8);
		case op of
			1: ret_film;
			2: dev_film;
			3: busca_film;
			4: busca_cli;
			5: new_film;
			6: new_cad;
			7: ask2:='N';
			end;{end do case}
		clrscr;
		end; {end do while}
	readln;
End. {Fim do Programa Principal}
