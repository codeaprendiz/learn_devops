package traefik_add_trace_id

import (
	"crypto/rand"
	"encoding/hex"
	"io"
)

var rander = rand.Reader // random function
type UUID [16]byte

func must(uuid UUID, err error) UUID {
	if err != nil {
		panic(err)
	}
	return uuid
}

func newUUID() UUID {
	return must(newRandom())
}

func newRandom() (UUID, error) {
	return newRandomFromReader(rander)
}

// newRandomFromReader returns a UUID based on bytes read from a given io.Reader.
func newRandomFromReader(r io.Reader) (UUID, error) {
	var uuid UUID
	_, err := io.ReadFull(r, uuid[:])
	if err != nil {
		return UUID{}, err
	}
	uuid[6] = (uuid[6] & 0x0f) | 0x40 // Version 4
	uuid[8] = (uuid[8] & 0x3f) | 0x80 // Variant is 10
	return uuid, nil
}

// String returns the string form of uuid, xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
// , or "" if uuid is invalid.
func (uuid UUID) String() string {
	var buf [36]byte
	encodeHex(buf[:], uuid)
	return string(buf[:])
}

func encodeHex(dst []byte, uuid UUID) {
	hex.Encode(dst, uuid[:4])
	dst[8] = '-'
	hex.Encode(dst[9:13], uuid[4:6])
	dst[13] = '-'
	hex.Encode(dst[14:18], uuid[6:8])
	dst[18] = '-'
	hex.Encode(dst[19:23], uuid[8:10])
	dst[23] = '-'
	hex.Encode(dst[24:], uuid[10:])
}
