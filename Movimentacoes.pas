unit Movimentacoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.StdCtrls, FMX.ListView, FMX.DateTimeCtrls, FMX.Controls.Presentation,
  FMX.Objects, FMX.Layouts;

type
  TFrmMovimentacoes = class(TForm)
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
    LEntradaseSaidas: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    lblEntradas: TLabel;
    lblSaidas: TLabel;
    LTotal: TLayout;
    Label3: TLabel;
    lblTotal: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dataChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     procedure listar;
    procedure totalizar;
    procedure totalizarEntradas;
    procedure totalizarSaidas;
  public
    { Public declarations }
  end;

var
  FrmMovimentacoes: TFrmMovimentacoes;
  TotEntradas : double;
  TotSaidas : double;

implementation

{$R *.fmx}

uses Modulo;

procedure TFrmMovimentacoes.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFrmMovimentacoes.Button2Click(Sender: TObject);
begin
listar;
end;

procedure TFrmMovimentacoes.dataChange(Sender: TObject);
begin

listar;
end;

procedure TFrmMovimentacoes.FormShow(Sender: TObject);
begin
data.Date := Date;
listar;

end;

procedure TFrmMovimentacoes.listar;
var
item : TListViewItem;
begin

 dm.query_mov.Close;
  dm.query_mov.SQL.Clear;
  dm.query_mov.SQL.Add('select tipo, movimento, valor, funcionario from movimentacoes where data = :data order by id desc');
  dm.query_mov.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);

   dm.query_mov.Open;
  dm.query_mov.First;

  lista.Items.Clear;
  lista.BeginUpdate;

  while not dm.query_mov.Eof do
  begin
    item := lista.Items.Add;
    item.Detail := FormatFloat('R$ #,,,,0.00', dm.query_mov.FieldByName('valor').Value) + '     -     ' + dm.query_mov.FieldByName('tipo').AsString + '     -     ' + dm.query_mov.FieldByName('funcionario').AsString;
    item.Text := dm.query_mov.FieldByName('movimento').AsString;
    dm.query_mov.Next;
  end;

  lista.EndUpdate;
  totalizar;
totalizarEntradas;
totalizarSaidas;

end;

procedure TFrmMovimentacoes.totalizar;
var
tot: real;
begin
tot := TotEntradas - TotSaidas;
if tot >= 0 then
begin
  lbltotal.StyledSettings := lbltotal.StyledSettings - [TStyledSetting.ssFontColor];
  lbltotal.FontColor := $FF12710A;
  end
  else
  begin
  lbltotal.StyledSettings := lbltotal.StyledSettings - [TStyledSetting.ssFontColor];
  lbltotal.FontColor := $FFA60C0C;
end;

lblTotal.Text := FormatFloat('R$ #,,,,0.00', tot);




end;

procedure TFrmMovimentacoes.totalizarEntradas;
var
tot: real;
begin
dm.query_tot_mov.Close;
dm.query_tot_mov.SQL.Clear;
dm.query_tot_mov.SQL.Add('select sum(valor) as total from movimentacoes where data = :data and tipo = "Entrada" ') ;
dm.query_tot_mov.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
dm.query_tot_mov.Prepare;
dm.query_tot_mov.Open;
tot := dm.query_tot_mov.FieldByName('total').AsFloat;
TotEntradas := tot;
lblEntradas.Text := FormatFloat('R$ #,,,,0.00', tot);


end;

procedure TFrmMovimentacoes.totalizarSaidas;
var
tot: real;
begin
dm.query_tot_mov.Close;
dm.query_tot_mov.SQL.Clear;
dm.query_tot_mov.SQL.Add('select sum(valor) as total from movimentacoes where data = :data and tipo = "Saída" ') ;
dm.query_tot_mov.ParamByName('data').Value :=  FormatDateTime('yyyy/mm/dd', data.Date);
dm.query_tot_mov.Prepare;
dm.query_tot_mov.Open;
tot := dm.query_tot_mov.FieldByName('total').AsFloat;
TotSaidas := tot;
lblSaidas.Text := FormatFloat('R$ #,,,,0.00', tot);

end;

end.
