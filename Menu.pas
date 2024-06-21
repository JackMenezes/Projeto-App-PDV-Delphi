unit Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmMenu = class(TForm)
    LConteudo: TLayout;
    imgBack: TImage;
    LAreaMenu: TLayout;
    GridMenu: TGridPanelLayout;
    LRodapeMenu: TLayout;
    LTotal: TLayout;
    Label7: TLabel;
    lblTotal: TLabel;
    LEstoque: TLayout;
    LTopo: TLayout;
    imgBackTopo: TImage;
    imgLogoUsuario: TImage;
    LTextos: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    lblNome: TLabel;
    lblFuncao: TLabel;
    btnFechar: TButton;
    ImgVendas: TImage;
    imgProdutos: TImage;
    imgGastos: TImage;
    imgMovimentacoes: TImage;
    retEstoque: TRectangle;
    lblEstoque: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure ImgVendasClick(Sender: TObject);
    procedure imgMovimentacoesClick(Sender: TObject);
    procedure imgProdutosClick(Sender: TObject);
    procedure imgGastosClick(Sender: TObject);
    procedure retEstoqueClick(Sender: TObject);
    procedure lblEstoqueClick(Sender: TObject);
    procedure LEstoqueClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    procedure totalizarVendas;
    procedure verificarEstoque;
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.fmx}

uses Modulo, Vendas, Movimentacoes, Produtos, Gastos, EstoqueBaixo;
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TFrmMenu.btnFecharClick(Sender: TObject);
begin

Close;
end;

procedure TFrmMenu.FormActivate(Sender: TObject);
begin
totalizarVendas;
verificarEstoque;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
lblNome.Text := nomeUsuario;
lblFuncao.Text := cargoUsuario;
totalizarVendas;
verificarEstoque;
end;

procedure TFrmMenu.Image1Click(Sender: TObject);
begin
 FrmEstoqueBaixo := TFrmEstoqueBaixo.Create(self);
 FrmEstoqueBaixo.Show;
end;

procedure TFrmMenu.imgGastosClick(Sender: TObject);
begin
 FrmGastos := TFrmGastos.Create(self);
 FrmGastos.Show;
end;

procedure TFrmMenu.imgMovimentacoesClick(Sender: TObject);
begin
 FrmMovimentacoes := TFrmMovimentacoes.Create(self);
 FrmMovimentacoes.Show;
end;

procedure TFrmMenu.imgProdutosClick(Sender: TObject);
begin
FrmProdutos := TFrmProdutos.Create(self);
 FrmProdutos.Show;
end;

procedure TFrmMenu.ImgVendasClick(Sender: TObject);
begin

 FrmVendas := TFrmVendas.Create(self);
 FrmVendas.Show;
end;

procedure TFrmMenu.lblEstoqueClick(Sender: TObject);
begin
 FrmEstoqueBaixo := TFrmEstoqueBaixo.Create(self);
 FrmEstoqueBaixo.Show;
end;

procedure TFrmMenu.LEstoqueClick(Sender: TObject);
begin
  FrmEstoqueBaixo := TFrmEstoqueBaixo.Create(self);
 FrmEstoqueBaixo.Show;
end;

procedure TFrmMenu.retEstoqueClick(Sender: TObject);
begin
  FrmEstoqueBaixo := TFrmEstoqueBaixo.Create(self);
 FrmEstoqueBaixo.Show;
end;

procedure TFrmMenu.totalizarVendas;
var
tot: real;
begin
dm.query_tot_vendas.Close;
dm.query_tot_vendas.SQL.Clear;
dm.query_tot_vendas.SQL.Add('select sum(valor) as total from vendas where data = curDate() ') ;
dm.query_tot_vendas.Prepare;
dm.query_tot_vendas.Open;
tot := dm.query_tot_vendas.FieldByName('total').AsFloat;
lbltotal.Text := FormatFloat('R$ #,,,,0.00', tot);

end;

procedure TFrmMenu.verificarEstoque;
begin
      dm.query_produtos.Close;
       dm.query_produtos.SQL.Clear;
       dm.query_produtos.SQL.Add('SELECT nome, descricao, estoque, imagem from produtos where estoque <= 10');
       dm.query_produtos.Open;

       if dm.query_produtos.RecordCount > 0 then
       begin
       retEstoque.Fill.Color := $FFE87878;
       lblEstoque.Text := 'Estoque Baixo';
       end
       else
       begin
       retEstoque.Fill.Color := $FF80EC7C;
       lblEstoque.Text := 'Estoque Bom';
       end;
end;

end.
