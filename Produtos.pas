unit Produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts;

type
  TFrmProdutos = class(TForm)
    LBackground: TLayout;
    ImgBack: TImage;
    LConteudo: TLayout;
    LTopo: TLayout;
    imgBackTopo: TImage;
    Button1: TButton;
    Button2: TButton;
    edtBuscar: TEdit;
    LAreaGrid: TLayout;
    lista: TListView;
    Image1: TImage;
    Circle1: TCircle;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBuscarChangeTracking(Sender: TObject);
  private
    { Private declarations }
    procedure listar;

  public
    { Public declarations }
  end;

var
  FrmProdutos: TFrmProdutos;

implementation

{$R *.fmx}

uses Modulo;



procedure TFrmProdutos.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFrmProdutos.Button2Click(Sender: TObject);
begin
listar;
end;

procedure TFrmProdutos.edtBuscarChangeTracking(Sender: TObject);
begin
listar;
end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
listar;
end;

procedure TFrmProdutos.listar;
var
item : TListViewItem;
streamImg : TStream;
begin
dm.query_produtos.Active := true;
 dm.query_produtos.Close;
  dm.query_produtos.SQL.Clear;
  dm.query_produtos.SQL.Add('select nome, descricao, estoque, imagem from produtos where nome like :nome order by estoque asc');
  dm.query_produtos.ParamByName('nome').AsString := edtBuscar.Text + '%';
   dm.query_produtos.Open;
  dm.query_produtos.First;

  lista.Items.Clear;
  lista.BeginUpdate;

  while not dm.query_produtos.Eof do
  begin

    streamImg := TMemoryStream.Create;

    if dm.query_produtos.FieldByName('imagem').IsNull then
    begin
      Image1.Bitmap.SaveToStream(streamImg);
      end
      else
      begin
      dm.query_produtosimagem.SaveToStream(streamImg);
    end;



    item := lista.Items.Add;
    item.Text :=  dm.query_produtos.FieldByName('nome').AsString;
    item.Detail := dm.query_produtos.FieldByName('descricao').AsString + ' - Estoque = ' + dm.query_produtos.FieldByName('estoque').AsString;
    circle1.Fill.Bitmap.Bitmap.LoadFromStream(streamImg);
    item.Bitmap := circle1.MakeScreenshot;

    dm.query_produtos.Next;
  end;

  lista.EndUpdate;


end;

end.
