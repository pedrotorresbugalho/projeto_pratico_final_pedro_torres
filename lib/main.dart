//Pedro Torres Bugalho

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicativo Prático Flutter',
      initialRoute: 't0',
      routes: {
        't0': (context) => TelaLogin(),
        't1': (context) => CriarConta(),
        't2': (context) => TelaMenu(),
        't3': (context) => TelaSobre(),
        't4': (context) => TelaLista(),
        't5': (context) => InserirDocumento(),
      },
    ),
  );
}

//
// TELA DE LOGIN
//
//
class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800),
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtEmail,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock), labelText: 'Senha'),
            ),
            const SizedBox(height: 40),
            Container(
              width: 150,
              child: OutlinedButton(
                child: const Text('Entrar'),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  login(txtEmail.text, txtSenha.text);
                },
              ),
            ),
            const SizedBox(height: 60),
            Container(
              width: 150,
              child: OutlinedButton(
                child: Text('Criar conta'),
                onPressed: () {
                  Navigator.pushNamed(context, 't1');
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void login(email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      Navigator.pushNamed(context, 't2');
    }).catchError((erro) {
      var mensagem = '';
      if (erro.code == 'user-not-found') {
        mensagem = 'ERRO: Usuário não encontrado';
      } else if (erro.code == 'wrong-password') {
        mensagem = 'ERRO: Senha incorreta';
      } else if (erro.code == 'invalid-email') {
        mensagem = 'ERRO: Email inválido';
      } else {
        mensagem = erro.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(mensagem), duration: const Duration(seconds: 2)));
    });
  }
}

//
// TELA DE CADASTRO
//
//
class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  _CriarContaState createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cadastro de Usuário'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800),
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtEmail,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w300),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: txtSenha,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Senha',
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: const Text('Criar'),
                    onPressed: () {
                      criarConta(txtEmail.text, txtSenha.text);
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  void criarConta(email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário cadastrado com sucesso'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }).catchError((erro) {
      if (erro.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ERRO: O email informado já está em uso'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ERRO: ${erro.message}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }
}

//
//TELA DO MENU
//
//
class TelaMenu extends StatefulWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  _TelaMenuState createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 't3');
                },
                child: Text('Sobre'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 't4');
                },
                child: Text('Lista'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: Text('SAIR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// TELA SOBRE
//
//
class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tema:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Aplicativo para controle de compras.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Objetivo:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Utilizar ao máximo as funcionalidades aprendidas em Programação Dispositivos Móveis.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Desenvolvedor:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Pedro Torres Bugalho.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 378,
              width: 302,
              child: Image.asset('lib/imagens/pedro.png'),
            ),
            SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

//
// TELA LISTA
//
//
class TelaLista extends StatefulWidget {
  const TelaLista({Key? key}) : super(key: key);

  @override
  _TelaListaState createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  late CollectionReference compras;

  @override
  void initState() {
    super.initState();

    compras = FirebaseFirestore.instance.collection('compras');
  }

  Widget itemLista(item) {
    String nome = item.data()['nome'];
    String preco = item.data()['preco'];

    return ListTile(
      title: Text(nome, style: const TextStyle(fontSize: 30)),
      subtitle: Text('R\$ $preco', style: const TextStyle(fontSize: 25)),
      trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            compras.doc(item.id).delete();
          }),
      onTap: () {
        Navigator.pushNamed(context, 't5', arguments: item.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: compras.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                    child: Text('Não foi possível conectar ao Firebase'));

              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      return itemLista(dados.docs[index]);
                    });
            }
          }),
      backgroundColor: Colors.blue.shade100,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade800,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 't5');
        },
      ),
    );
  }
}

//
// INSERIR DOCUMENTOS
//
//
class InserirDocumento extends StatefulWidget {
  const InserirDocumento({Key? key}) : super(key: key);

  @override
  _InserirDocumentoState createState() => _InserirDocumentoState();
}

class _InserirDocumentoState extends State<InserirDocumento> {
  var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  getDocumentById(id) async {
    await FirebaseFirestore.instance
        .collection('compras')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtPreco.text = doc.get('preco');
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text.isEmpty && txtPreco.text.isEmpty) {
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade800,
      ),
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            TextField(
              controller: txtNome,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtPreco,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: OutlinedButton(
                    child: const Text('salvar'),
                    onPressed: () {
                      if (id == null) {
                        FirebaseFirestore.instance.collection('compras').add(
                            {'nome': txtNome.text, 'preco': txtPreco.text});
                      } else {
                        FirebaseFirestore.instance
                            .collection('compras')
                            .doc(id.toString())
                            .set(
                                {'nome': txtNome.text, 'preco': txtPreco.text});
                      }

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Atualização concluída'),
                        duration: Duration(seconds: 2),
                      ));

                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Container(
                  width: 150,
                  child: OutlinedButton(
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
