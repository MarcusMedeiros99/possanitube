#include <iostream>
#include <pqxx/pqxx>
#include <string>

void list_professor(pqxx::connection &c){
	// Start a transaction.
	pqxx::work w(c);

	pqxx::result r = w.exec("SELECT username FROM usuario WHERE (tipo & B'0100' = B'0100');");

	// Not really needed, since we made no changes, but good habit to be
	// explicit about when the transaction is done.
	w.commit();

	for (auto const &row: r){
		for (auto const &field: row) std::cout << field.c_str() << '\t';
		std::cout << '\n';
	}
}

void buscar_aula_por_professor(pqxx::connection &c){
	std::string username;

	std::cout << "Username do Professor: ";
	std::cin >> username;
	username.resize(20);

	if(username.empty()){
		std::cout << "ERRO: Username não pode ser vazio." << std::endl;
		return;
	}

	// Start a transaction.
	pqxx::work w(c);

	// Execute an SQL statement with parameters.
	pqxx::result r = w.exec_params("SELECT tipo FROM usuario WHERE (username = $1 );", username);

	// Not really needed, since we made no changes, but good habit to be
	// explicit about when the transaction is done.
	w.commit();

	// check if user exists
	if(r.empty()){
		std::cout << username << " não existe." << std::endl;
		return;
	}

	// check second character of bit string fot user type
	if(r[0][0].as<std::string>()[1] != '1'){
		std::cout << username << " não é um professor." << std::endl;
		return;
	}

	r = w.exec_params("SELECT * FROM aula WHERE (professor = $1 );", username);

	// list fields
	for (auto const &row: r){
		for (auto const &field: row) std::cout << field.c_str() << '\t';
		std::cout << std::endl;
	}
}

void add_aluno(pqxx::connection &c){
	std::string username, email, nome;

	std::cout << "Username: ";
	std::cin >> username;
	username.resize(20);

	if(username.empty()){
		std::cout << "ERRO: Username não pode ser vazio." << std::endl;
		return;
	}

	std::cout << "e-mail: ";
	std::cin >> email;
	email.resize(20);

	std::cout << "Nome: ";
	std::cin.ignore(); // Deletes newline buffer
	std::getline(std::cin, nome); // For reading spaces
	nome.resize(30);

	// Start a transaction.
	pqxx::work w(c);

	// Execute an SQL statement with parameters.
	pqxx::result r = w.exec_params("SELECT * FROM usuario WHERE (username = $1 );", username);

	// Not really needed, since we made no changes, but good habit to be
	// explicit about when the transaction is done.
	w.commit();

	// check if user exists
	if(!r.empty()){
		std::cout << username << " já existe." << std::endl;
		return;
	}

	// Execute an SQL statement with parameters.
	w.exec_params("INSERT INTO usuario VALUES ($1, $2, $3, B'1000');",
					username, email, nome);

	// Commit your transaction. If an exception occurred before this
	// point, execution will have left the block, and the transaction will
	// have been destroyed along the way. In that case, the failed
	// transaction would implicitly abort instead of getting to this point.
	w.commit();

	std::cout << "Usuário " << username << " registrado como aluno." << std::endl;
}

int main(){
	int choice = -1;

	try{
		// Connect to the database. In practice we may have to pass some
		// arguments to say where the database server is, and so on.
		// The constructor parses options exactly like libpq's
		// PQconnectdb/PQconnect, see:
		// https://www.postgresql.org/docs/10/static/libpq-connect.html
		pqxx::connection c("host=localhost port=5432 dbname=possanitube user=admin password=admin connect_timeout=10");

		do{
			std::cout << "\n+---------------+\n"
						"|  Possanitube  |\n"
						"+---------------+\n\n"

						"Menu:\n\n"

						"1) Inserir Aluno\n"
						"2) Listar Professores\n"
						"3) Buscar Aula por Professor\n"
						"4) Sair\n"

						"\nDigite sua escolha: ";

			// Checks for valid input
			if (!(std::cin >> choice)) {
				if (std::cin.eof()) {
					std::cout << "Usuário terminou input." << std::endl;
					return 0;
				}

				std::cout << "\n(Não é um número)";
				std::cin.clear();
				std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
				choice = -1;
			}

			std::cout << std::endl;

			switch(choice){
				case 1:
					add_aluno(c);
					break;
				case 2:
					list_professor(c);
					break;
				case 3:
					buscar_aula_por_professor(c);
					break;
				case 4:
					break;
				default:
					std::cout << "Valor inválido." << std::endl;
			}
		}while(choice != 4);

	}catch (std::exception const &e){
		std::cerr << e.what() << std::endl;
		return 1;
	}

	return 0;
}