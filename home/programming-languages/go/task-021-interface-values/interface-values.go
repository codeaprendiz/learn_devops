package main

import (
	"fmt"
	"math"
)

type m_interface interface {
	m_interface_function()
}

type m_struct struct {
	m_struct_string string
}

func (m_pointer_to_struct_obj *m_struct) m_interface_function() {
	fmt.Println(m_pointer_to_struct_obj.m_struct_string)
}

type m_float float64

func (m_float_obj m_float) m_interface_function() {
	fmt.Println(m_float_obj)
}

func describe(m_interface_obj m_interface) {
	fmt.Printf("(%v, %T)\n", m_interface_obj, m_interface_obj)
}

func main() {
	var m_interface_obj m_interface

	m_interface_obj = &m_struct{"hello"}
	describe(m_interface_obj)
	m_interface_obj.m_interface_function()

	m_interface_obj = m_float(math.Pi)
	describe(m_interface_obj)
	m_interface_obj.m_interface_function()
}
