// 表头
tablecolumns1: [
	{
		type: 'selection',
		width: 60,
		align: 'center',
		fixed: 'left'
	},
	{
		title: '父字段一',
		key: 'field1',
		align: 'center',
		width: 70
	},
	{
		title: '父字段二',
		key: 'field2',
		align: 'center',
		width: 90,
		render: (h, params) => {
			return h('div', [
				params.row.field2.toLocaleString()
			]);
		}
	},
	{
		title: '检查信息',
		align: 'center',
		children: [
			{
				title: '编号',
				key: 'jianchaxinxi',
				align:'center',
				width: 50,
				className: 'table-info-column-jianchaxinxi',
				render: (h, params) => {
					return h('div', {
						attrs: {
							class:'subCol'
						},
					}, [
						h('ul', params.row.jianchaxinxi.map((item, index) => {
							return h('li', {
							}, ++index)
						}))
					]);
				}
			},
			{
				title: '检查内容',
				key: 'jianchaxinxi',
				align:'center',
				width: 170,
				className: 'table-info-column-jianchaxinxi',
				render: (h, params) => {
					return h('div', {
						attrs: {
							class:'subCol'
						},
					}, [
						h('ul', params.row.jianchaxinxi.map(item => {
							return h('li', {
							}, item.jianchaneirong == null || item.buliangneirong == '' ? '-' : item.jianchaneirong)
						}))
					]);
				}
			},
			{
				title: '检查者',
				key: 'jianchaxinxi',
				align:'center',
				width: 90,
				className: 'table-info-column-jianchaxinxi',
				render: (h, params) => {
					return h('div', {
						attrs: {
							class:'subCol'
						},
					}, [
						h('ul', params.row.jianchaxinxi.map(item => {
							return h('li', {
							}, item.jianchazhe == null || item.jianchazhe == '' ? '-' : item.jianchazhe)
						}))
					]);
				}
			},
			{
				title: '操作',
				key: 'action',
				align: 'center',
				width: 110,
				className: 'table-info-column-jianchaxinxi',
				render: (h, params) => {
					return h('div', {
							attrs: {
								class:'subCol'
							},
						}, [
						h('ul', params.row.jianchaxinxi.map((item, index) => {
							return h('li', {
							}, [
								h('Button', {
									props: {
										type: 'default',
										size: 'small'
									},
									style: {
										marginRight: '5px'
									},
									on: {
										click: () => {
											// something to call
										}
									}
								}, '编辑'),
								h('Button', {
									props: {
										type: 'warning',
										size: 'small'
									},
									style: {
										marginRight: '5px'
									},
								}, [
									h('span', {
									}, [
										h('Poptip', {
											props: {
												'word-wrap': true,
												'trigger': 'click',
												'confirm': true,
												'title': '真的要删除吗？',
												'transfer': true
											},
											on: {
												'on-ok': () => {
													// something to call
												}
											}
										}, '删除')
									])
								]),

							])
						}))
					]);
				},
			},
		]
	},
	{
		title: '操作',
		key: 'action',
		align: 'center',
		width: 130,
		render: (h, params) => {
			return h('div', [
				h('Button', {
					props: {
						type: 'info',
						size: 'small'
					},
					style: {
						marginRight: '5px'
					},
					on: {
						click: () => {
							// something to call
						}
					}
				}, '编辑'),
				h('Button', {
					props: {
						type: 'default',
						size: 'small'
					},
					style: {
						marginRight: '5px'
					},
					on: {
						click: () => {
							// something to call
						}
					}
				}, '追加'),
			]);
		},
		fixed: 'right'
	},
],