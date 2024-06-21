unit Gastos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Objects, FMX.ListView, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.DateTimeCtrls, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFrmGastos = class(TForm)
    LBackground: TLayout;
    ImgBack: TImage;
    LConteudo: TLayout;
    LTopo: TLayout;
    imgBackTopo: TImage;
    Button1: TButton;
    LAreaGrid: TLayout;
    lista: TListView;
    LRodapeForm: TLayout;
    imgBackRodape: TImage;
    btnDeletar: TButton;
    btnEditar: TButton;
    btnInserir: TButton;
    data: TDateEdit;
    Button2: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure dataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
  private
    { Private declarations }
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmGastos: TFrmGastos;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses Modulo, InserirGastos;

{ TFrmGastos }

procedure TFrmGastos.btnDeletarClick(Sender: TObject);
begin

  idGasto := dm.query_gastos.FieldByName('id').Value;

  dm.query_gastos.Close;
  dm.query_gastos.SQL.Clear;
  dm.query_gastos.SQL.Add('DELETE FROM gastos where id = :id');

  dm.query_gastos.ParamByName('id').Value :=  idGasto;
  dm.query_gastos.ExecSql;



  //DELETAR TAMBÉM NA TABELA DE MOVIMENTAÇÕES
      dm.query_mov_inserir.Close;
      dm.query_mov_inserir.SQL.Clear;
      dm.query_mov_inserir.SQL.Add('DELETE FROM movimentacoes where id_movimento = :id');
      dm.query_mov_inserir.ParamByName('id').Value := idGasto;
      dm.query_mov_inserir.ExecSQL;


  showMessage('Deletado com Sucesso!');
  listar;

end;

procedure TFrmGastos.btnEditarClick(Sender: TObject);
begin
acao := 'Editar';

if dm.query_gastos.FieldByName('motivo').Value <> null then
motivoGasto := dm.query_gastos.FieldByName('motivo').Value;

if dm.query_gastos.FieldByName('valor').Value <> null then
valorGasto := dm.query_gastos.FieldByName('valor').Value;

idGasto := dm.query_gastos.FieldByName('id').Value;


Application.CreateForm(TFrmInserirGastos,FrmInserirGastos);
FrmInserirGastos.Show;
end;

procedure TFrmGastos.btnInserirClick(Sender: TObject);
begin
acao := 'Inserir';
Application.CreateForm(TFrmInserirGastos,FrmInserirGastos);
FrmInserirGastos.Show;
end;

procedure TFrmGastos.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFrmGastos.Button2Click(Sender: TObject);
begin
listar;
end;

procedure TFrmGastos.dataChange(Sender: TObject);
begin
listar;
end;

procedure TFrmGastos.FormActivate(Sender: TObject);
begin
listar;
end;

procedure TFrmGastos.FormShow(Sender: TObject);
begin
data.Date := Date;
listar;
end;

procedure TFrmGastos.listar;
var
item : TListViewItem;
begin

  dm.query_gastos.Close;
  dm.query_gastos.SQL.Clear;
  dm.query_gastos.SQL.Add('select * from gastos where data = :data order by id desc');
  dm.query_gastos.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);

  dm.query_gastos.Open;
  dm.query_gastos.First;

  lista.Items.Clear;
  lista.BeginUpdate;

  while not dm.query_gastos.Eof do
  begin
    item := lista.Items.Add;
    item.Text := FormatFloat('R$ #,,,,0.00', dm.query_gastos.FieldByName('valor').Value);
    item.Detail := dm.query_gastos.FieldByName('motivo').AsString + '  -  ' + dm.query_gastos.FieldByName('funcionario').AsString;
    dm.query_gastos.Next;
  end;

  lista.EndUpdate;


end;

end.
