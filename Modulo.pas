unit Modulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, MyAccess, MemDS;

type
  Tdm = class(TDataModule)
    con: TMyConnection;
    query_usuarios: TMyQuery;
    query_tot_vendas: TMyQuery;
    query_produtos: TMyQuery;
    query_vendas: TMyQuery;
    query_vendasvalor: TFloatField;
    query_vendasfuncionario: TStringField;
    query_mov: TMyQuery;
    query_tot_mov: TMyQuery;
    query_movtipo: TStringField;
    query_movmovimento: TStringField;
    query_movvalor: TFloatField;
    query_movfuncionario: TStringField;
    query_produtosnome: TStringField;
    query_produtosdescricao: TStringField;
    query_produtosestoque: TIntegerField;
    query_produtosimagem: TBlobField;
    query_gastos: TMyQuery;
    query_gastosmotivo: TStringField;
    query_gastosvalor: TFloatField;
    query_gastosfuncionario: TStringField;
    query_gastosdata: TDateField;
    query_gastosid: TIntegerField;
    query_mov_inserir: TMyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

  nomeUsuario : string;
  cargoUsuario : string;

  acao : string;


  //VARIAVEIS GLOBAIS PARA EDIÇÃO
  motivoGasto : string;
  valorGasto : double;
  idGasto : string;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
con.Connected := true;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
con.Connected := false;
end;

end.
