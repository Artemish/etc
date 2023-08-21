#!/usr/bin/env python

# Quick script I wrote with the help of ChatGPT to overlay barcodes in sequences of 4
# (i.e. barcode0.png on page 1, barcode1.png on page 2... barcode0.png on page 5) on
# top of a source PDF, as part of a data correction procedure at work

# requires PyPDF2, reportlab, and curses

import os
import sys
import subprocess
import PyPDF2

from io import BytesIO
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter

import curses

def get_adjustment_key(stdscr):
    stdscr.nodelay(0)  # Make getch non-blocking
    stdscr.timeout(100)  # Refresh every 100ms

    print("Adjust the barcode using arrow keys. Rotate with PageUp/PageDown. Press 'Enter' to accept.")

    while True:
        key = stdscr.getch()
        if key == curses.KEY_LEFT:
            return 'left'
        elif key == curses.KEY_RIGHT:
            return 'right'
        elif key == curses.KEY_UP:
            return 'up'
        elif key == curses.KEY_DOWN:
            return 'down'
        elif key == curses.KEY_PPAGE:
            return 'page up'
        elif key == curses.KEY_NPAGE:
            return 'page down'
        elif key == ord('+') or key == ord('='):  # + is usually the same key as = on keyboards
            return 'scale up'
        elif key == ord('-'):
            return 'scale down'
        elif key == 10:  # Enter key
            return 'enter'

def overlay_and_adjust_barcode(input_pdf, output_pdf):
    output = PyPDF2.PdfWriter()

    x_position = 360
    y_position = 728
    barcode_width = 120
    barcode_height = 50
    rotate_angle = 0  # Initial rotation angle

    with open(input_pdf, "rb") as file:
        pdf = PyPDF2.PdfReader(file)

        for page_num in range(len(pdf.pages)):
            original_page = pdf.pages[page_num]
            barcode_filename = f"barcode{page_num % 4}.png"

            while True:  # Infinite loop until barcode position is accepted
                reader = PyPDF2.PdfReader(open(input_pdf, "rb"))
                # Create temporary PDF with the barcode image
                packet = BytesIO()
                c = canvas.Canvas(packet, pagesize=letter)
                c.saveState()
                c.rotate(rotate_angle)
                c.drawImage(barcode_filename, x_position, y_position, width=barcode_width, height=barcode_height)
                c.restoreState()
                c.showPage()
                c.save()
                packet.seek(0)
                barcode_pdf = PyPDF2.PdfReader(packet)
                
                # Merge the barcode overlay with the original page
                temp_page = reader.pages[page_num]
                temp_page.merge_page(barcode_pdf.pages[0])
            
                # Create a new temporary writer for combined content
                temp_writer = PyPDF2.PdfWriter()
                temp_writer.add_page(temp_page)
            
                # Save and display temp PDF
                temp_filename = "temp_output.pdf"
                with open(temp_filename, "wb") as temp_file:
                    temp_writer.write(temp_file)
                
                evince_process = subprocess.Popen(["evince", temp_filename])
            
                # Prompt user for adjustment
                key = curses.wrapper(get_adjustment_key)
            
                if key == 'left':
                    x_position -= 2
                elif key == 'right':
                    x_position += 2
                elif key == 'up':
                    y_position += 2
                elif key == 'down':
                    y_position -= 2
                elif key == 'page up':
                    rotate_angle -= 1
                elif key == 'page down':
                    rotate_angle += 1
                elif key == 'scale up':
                    barcode_width *= 1.05  # Increase by 5%
                    barcode_height *= 1.05  # Increase by 5%
                elif key == 'scale down':
                    barcode_width *= 0.95  # Decrease by 5%
                    barcode_height *= 0.95  # Decrease by 5%
                
                # Kill the evince process and remove the temp file
                evince_process.terminate()
                if os.path.exists(temp_filename):
                    os.remove(temp_filename)

                if key == "enter":
                    # Merge temp PDF to output PDF
                    packet.seek(0)
                    barcode_pdf = PyPDF2.PdfReader(packet)
                    page = original_page
                    page.merge_page(barcode_pdf.pages[0])
                    output.add_page(page)
                    break  # Exit the loop to move to next page

    # Save the final output PDF
    with open(output_pdf, "wb") as out:
        output.write(out)

    # Clean up the temp file
    if os.path.exists(temp_filename):
        os.remove(temp_filename)

# Initial values
# input_pdf_file = "path_to_input.pdf"
# output_pdf_file = "path_to_output.pdf"

if __name__ == '__main__':
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    overlay_and_adjust_barcode(input_file, output_file)
