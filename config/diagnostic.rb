module Edge
  class DiagnosticMiddleware
    FILENAME = File.join(Rails.root, 'log', 'test.log')

    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env)
    rescue StandardError => e
      trace = e.backtrace.select{ |l|l.start_with?(Rails.root.to_s) }.join("\n    ")
      msg = "#{e.class}\n#{e.message}\n#{trace}\n"
      File.open(FILENAME, 'a') { |f|
        f.write "\n"
        f.write "\n"
        f.write " ---   BACKTRACE   --- \n"
        f.write "\n"

        f.write msg

        f.write "\n"
        f.write " ---   BACKTRACE   --- \n"
        f.write "\n"
        f.write "\n"
      }
      raise e
    end
  end
end

