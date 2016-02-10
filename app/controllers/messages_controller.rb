class MessagesController < ApplicationController
  def index
    @message = Message.new   # @message = Message.newで、Messageモデルのオブジェクトの初期化を行い、@messageに代入を行っている。
    #Meaageを全て取得する
    @messages = Message.all
  end
  
  #メッセージを作成する処理の流れは以下のようになっています。
  #先ほどのフォームに値を入力し送信ボタンを押すと /messagesというURLにPOSTでリクエストがパラメータと共に送信されます。その後、routes.rbで設定したMessagesControllerのcreateアクションが呼ばれます。
  
  def create
    @message = Message.new(message_params)
    if @message.save
    redirect_to root_path , notice: 'メッセージを保存しました。'
    else
      #メッセージが保存できなかった時は @messageのerrorsメソッドでエラーメッセージを取得することができます。
      @message = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"    #エラーメッセージをflash.now[:alert]に代入しています。
      render 'index'
    end
  end
  
  #nameと、bodyが含まれたパラメータ(message_params)を受け取り、 message_paramsの内容をもとにMessageモデルのインスタンスを生成(Message.new)し、変数@messageに代入しています。
  # ※ message_paramsについては次のストロングパラメータについての項で説明します。
  # @message.save でメッセージモデルのインスタンスをデータベースに保存しています。
  # ルートURLにリダイレクトしています。
  
  private
  def message_params
    params.require(:message).permit(:name, :body)
    #def message_paramsはparamsに:messageというキーが存在するか検証し、存在する場合はparams[:message]のうち、キーが:nameと:bodyの値のみ受け取るようにフィルタリングを行っています
  end
  ## ここまで
  # ブラウザのフォームから送信されたパラメータは、コントローラ側からは params で取得できます。
end

  
