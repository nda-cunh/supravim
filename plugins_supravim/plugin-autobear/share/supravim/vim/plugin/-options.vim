vim9script noclear

if !exists('*supraconfig#RegisterMany')
	finish
endif

supraconfig#RegisterMany([
	{
		id: 'ft_count_line',
		type: 'bool',
		default: true,
		lore: 'Enable the count line feature',
		handler: (v) => {
			Ft_count_line.SimpleSupravimChangeOption(v == 'true')
		}
	},
])
