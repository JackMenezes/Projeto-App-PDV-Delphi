program APPPDV;

uses
  System.StartUpCopy,
  FMX.Forms,
  Login in 'Login.pas' {FrmLogin},
  Modulo in 'Modulo.pas' {dm: TDataModule},
  Menu in 'Menu.pas' {FrmMenu},
  Vendas in 'Vendas.pas' {FrmVendas},
  Movimentacoes in 'Movimentacoes.pas' {FrmMovimentacoes},
  Produtos in 'Produtos.pas' {FrmProdutos},
  Gastos in 'Gastos.pas' {FrmGastos},
  EstoqueBaixo in 'EstoqueBaixo.pas' {FrmEstoqueBaixo},
  InserirGastos in 'InserirGastos.pas' {FrmInserirGastos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmVendas, FrmVendas);
  Application.CreateForm(TFrmMovimentacoes, FrmMovimentacoes);
  Application.CreateForm(TFrmProdutos, FrmProdutos);
  Application.CreateForm(TFrmGastos, FrmGastos);
  Application.CreateForm(TFrmEstoqueBaixo, FrmEstoqueBaixo);
  Application.Run;
end.
