
# pdf.text("Prawn Rocks")

pdf.text "Monthly Income", :align=>:center, :size=>14

incomes = @incomes.map do |income|
  [
    income.id,
    income.particular,
    income.description,
    income.amount
  ]
end

pdf.table incomes, :border_style => :grid,
  :row_colors => ["FFFFFF","DDDDDD"],
  :headers => ["Id", "Particular", "Description", "Amount"],
  :align => { 0 => :left, 1 => :right, 2 => :right, 3 => :right },
  :position => :center

pdf.move_down(80)

pdf.text "End of page", :align=>:center, :size=>4
