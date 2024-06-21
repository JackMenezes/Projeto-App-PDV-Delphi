unit Vendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.ListView, FMX.DateTimeCtrls, FMX.Controls.Presentation,
  FMX.Objects, FMX.Layouts;

type
  TFrmVendas = class(TForm)
    LBackground: TLayout;
    ImgBack: TImage;
    LConteudo: TLayout;
    LTopo: TLayout;
    imgBackTopo: TImage;
    Button1: TButton;
    Button2: TButton;
    data: TDateEdit;
    LAreaGrid: TLayout;
    lista: TListView;
    LRodapeForm: TLayout;
    imgBackRodape: TImage;
    LTotal: TLayout;
    Label3: TLabel;
    lblTotal: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dataChange(Sender: TObject);
  private
    { Private declarations }
    procedure listar;
    procedure totalizar;
  public
    { Public declarations }
  end;

var
  FrmVendas: TFrmVendas;

implementation

{$R *.fmx}

uses Modulo, Gastos;

procedure TFrmVendas.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFrmVendas.Button2Click(Sender: TObject);
begin
listar;
end;

procedure TFrmVendas.dataChange(Sender: TObject);
begin
listar;
end;

procedure TFrmVendas.FormShow(Sender: TObject);
begin
data.Date := Date;
listar;

end;

procedure TFrmVendas.listar;
var
item : TListViewItem;
begin
dm.query_vendas.Active := true;
 dm.query_vendas.Close;
  dm.query_vendas.SQL.Clear;
  dm.query_vendas.SQL.Add('select valor, data, funcionario, status from vendas where data = :data and status = :status order by id desc');
  dm.query_vendas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);

  dm.query_vendas.ParamByName('status').Value :=  'Concluída';
  dm.query_vendas.Open;
  dm.query_vendas.First;

  lista.Items.Clear;
  lista.BeginUpdate;

  while not dm.query_vendas.Eof do
  begin
    item := lista.Items.Add;
    item.Text := FormatFloat('R$ #,,,,0.00', dm.query_vendas.FieldByName('valor').Value);
    item.Detail := dm.query_vendas.FieldByName('funcionario').AsString;
    dm.query_vendas.Next;
  end;

  lista.EndUpdate;
  totalizar;



end;

procedure TFrmVendas.totalizar;
var
tot: real;
begin
dm.query_tot_vendas.Close;
dm.query_tot_vendas.SQL.Clear;
dm.query_tot_vendas.SQL.Add('select sum(valor) as total from vendas where data = :data ') ;
dm.query_tot_vendas.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
dm.query_tot_vendas.Prepare;
dm.query_tot_vendas.Open;
tot := dm.query_tot_vendas.FieldByName('total').AsFloat;
lbltotal.Text := FormatFloat('R$ #,,,,0.00', tot);


end;

end.
