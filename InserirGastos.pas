unit InserirGastos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFrmInserirGastos = class(TForm)
    LBackground2: TLayout;
    ImgBack: TImage;
    LConteudo: TLayout;
    LTopo: TLayout;
    imgBackTopo: TImage;
    Button2: TButton;
    lblTitulo: TLabel;
    LAreaGrid: TLayout;
    Label2: TLabel;
    edtMotivo: TEdit;
    Label3: TLabel;
    edtValor: TEdit;
    LRodapeForm: TLayout;
    imgBackRodape: TImage;
    btnSalvar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInserirGastos: TFrmInserirGastos;
  idGasto : string;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses Modulo;

procedure TFrmInserirGastos.btnSalvarClick(Sender: TObject);
begin

if Trim(EdtMotivo.Text) = '' then
       begin
           showMessage('Preencha o Motivo!');
           EdtMotivo.SetFocus;
           exit;
     end;

      if Trim(EdtValor.Text) = '' then
       begin
           showMessage('Preencha o Valor!');
           EdtValor.SetFocus;
           exit;
     end;

if acao = 'Inserir' then
begin



  dm.query_gastos.Active := true;
  dm.query_gastos.Close;
  dm.query_gastos.SQL.Clear;
  dm.query_gastos.SQL.Add('INSERT INTO gastos (motivo, valor, funcionario, data) VALUES (:motivo, :valor, :funcionario, curDate())');
  dm.query_gastos.ParamByName('motivo').Value :=  edtMotivo.Text;
  dm.query_gastos.ParamByName('valor').Value :=  edtValor.Text;
  dm.query_gastos.ParamByName('funcionario').Value :=  nomeUsuario;
  dm.query_gastos.ExecSql;



//RECUPERAR O ID DO ULTIMO GASTO INSERIDO
      dm.query_gastos.Close;
      dm.query_gastos.SQL.Clear;
      dm.query_gastos.SQL.Add('SELECT * from gastos order by id desc');

      dm.query_gastos.Open;

       if not dm.query_gastos.isEmpty then
       begin
         idGasto :=  dm.query_gastos['id'];
       end;


//LANÇAR O VALOR DO GASTO NAS MOVIMENTAÇÕES
       dm.query_mov_inserir.Close;
      dm.query_mov_inserir.SQL.Clear;
      dm.query_mov_inserir.SQL.Add('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) VALUES (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
      dm.query_mov_inserir.ParamByName('tipo').Value := 'Saída';
      dm.query_mov_inserir.ParamByName('movimento').Value := 'Gasto';
      dm.query_mov_inserir.ParamByName('valor').Value := edtValor.Text;
      dm.query_mov_inserir.ParamByName('funcionario').Value := nomeUsuario;
      dm.query_mov_inserir.ParamByName('id_movimento').Value := idGasto;
      dm.query_mov_inserir.ExecSQL;


  showMessage('Salvo com Sucesso!');
  Close;

end
else
begin

  dm.query_gastos.Close;
  dm.query_gastos.SQL.Clear;
  dm.query_gastos.SQL.Add('UPDATE gastos SET motivo = :motivo where id = :id');
  dm.query_gastos.ParamByName('motivo').Value :=  edtMotivo.Text;
  dm.query_gastos.ParamByName('id').Value :=  idGasto;
  dm.query_gastos.ExecSql;
  Close;

end;


end;

procedure TFrmInserirGastos.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TFrmInserirGastos.FormShow(Sender: TObject);
begin
if acao = 'Inserir' then
begin
lblTitulo.Text := 'CADASTRO DE GASTOS';
end
else
begin
lblTitulo.Text := 'EDITAR GASTOS';
edtValor.Enabled := false;
edtMotivo.Text := motivoGasto;
edtValor.Text := floatToStr(valorGasto);
end;


end;

end.
